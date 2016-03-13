class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user_id, index: true, foreign_key: true
      t.belongs_to :petition_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
