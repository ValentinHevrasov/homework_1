class Developer

  attr_reader :name, :task_list

  MAX_TASKS = 10

  def initialize(name)
    @name = name
    @task_list = []
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

  def work!
    rand(2).zero? ? (puts 'Что-то лень') : 2.times{work_task}
  end

end

dev = Developer.new('Вася')
