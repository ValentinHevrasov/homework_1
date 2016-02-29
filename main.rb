require 'byebug'
require 'pp'

class Developer

  attr_reader :name, :task_list

  MAX_TASKS = 10
  TYPE = :developer

  def initialize(name)
    @name = name
    @task_list = []
    @type = self.class::TYPE
  end

  def type
    @type
  end

  def tasks
    @task_list.map.with_index {|t, i| "#{i+1}. #{t}"}
  end

  def add_task (task)
    if @task_list.count >= self.class::MAX_TASKS
      raise 'Слишком много работы'
    else
      @task_list << task
      puts %Q(%s: добавлена задача "%s". Всего в списке задач: %i) %
      [@name, task, @task_list.count]
    end
  end

  def work!
    work_task
  end

  def work_task
    @task_list.empty? ? (raise 'Нечего делать!') : work_puts
  end

  def work_puts
    puts %Q(%s: выполнена задача "%s". Осталось задач: %i) %
    [@name, @task_list.shift, @task_list.count]
  end

  def status
    case @task_list.count
    when 0
      'свободен'
    when self.class::MAX_TASKS
      'занят'
    else
      'работаю'
    end
  end

  def can_add_task?
    @task_list.count != self.class::MAX_TASKS
  end

  def can_work?
    @task_list.count != 0
  end

end


class JuniorDeveloper < Developer
  MAX_TASKS = 5
  TYPE = :junior

  def type
    @type
  end

  def add_task (task)
    task.size >= 20 ? task_20 : super
  end

  def task_20
    raise 'Слишком сложно!'
  end


  def work_puts
    puts %Q(%s: пытаюсь сделать задачу "%s". Осталось задач: %i) %
    [@name, @task_list.shift, @task_list.count]
  end

end


class SeniorDeveloper < Developer
  MAX_TASKS = 15
  TYPE = :senior

  def type
    @type
  end

  def work!
    rand(2).zero? ? (puts 'Что-то лень') : 2.times{work_task}
  end

end



class Team
  attr_reader :priority, :team_list

  def initialize (&block)
    @team_list = {}
    @priority = []
    instance_eval &block
  end


  def have_seniors (*names)
    @team_list[:seniors] = names.map do
      |n| SeniorDeveloper.new(n)
    end
  end

  def have_developers(*names)
    @team_list[:developers] = names.map do
      |n| Developer.new(n)
    end
  end

  def have_juniors(*names)
    @team_list[:juniors] = names.map do
      |n| JuniorDeveloper.new(n)
    end
  end

  def seniors
    @team_list[:seniors]
  end

  def developers
    @team_list[:developers]
  end

  def juniors
    @team_list[:juniors]
  end

  def all
    @team_list.values.flatten
  end

  def priority (*names)
    @priority = names
  end

  def list
    (@team_list[@priority[0]] +
      @team_list[@priority[1]] +
      @team_list[@priority[2]]
    ).sort_by{|i| i.task_list.size}
    # .map{|i| i}
  end

  def report
    list.each do |i|
      puts %Q(%s (%s): %s)%
      [i.name, i.type, i.task_list.join(", ")]
    end
  end

  def add_task(task, **options)
    case 
    when options[:complexity]
    	# будет время уменьшить код
      people = list.select{|i| i.type == options[:complexity]}[0]
    when options[:to]
      people = list.select{|i| i.name == options[:to]}[0]
    else
      people = list[0]
    end
    people.add_task(task)
    @team_list[people.type].call(people, task)
    rescue NoMethodError
  end

  def on_task(type, &block)
    @team_list[type] = block
  end
end




t = Team.new{
  have_seniors 'Олег', 'Оксана'
  have_developers 'Олеся', 'Василий', 'Игорь-Богдан'
  have_juniors 'Владислава', 'Аркадий', 'Рамеш'
  priority :juniors, :developers, :seniors
  on_task :junior do |dev, task|
    puts "Отдали задачу #{task} разработчику #{dev.name}, следите за ним!"
  end
  on_task :senior do |dev, task|
    puts "#{dev.name} сделает #{task}, но просит больше с такими глупостями не приставать"
  end
}

t.add_task 'Задача #1'
t.add_task 'Задача #2'
t.add_task 'Задача #3'
t.add_task 'Задача #4'
t.add_task 'Задача #5'
t.add_task 'Задача #6'
t.add_task 'Задача #7'
t.add_task 'Задача #8'
t.add_task 'Задача #9'
t.add_task 'Задача #10'
t.add_task 'Задача #11'
t.add_task 'Задача #12'
t.add_task 'Задача #13'
t.add_task 'Задача #14'
t.add_task 'Задача #15'
t.add_task 'Задача #16'
t.add_task 'Задача #17'
t.add_task 'Задача #18'

t.add_task 'допзадача', complexity: :senior
t.add_task 'допзадача1', to: 'Василий'

pp t.seniors
pp t.developers
pp t.juniors
pp t.all
pp t.report