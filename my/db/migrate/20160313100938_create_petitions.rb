class CreatePetitions < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.string :title
      t.string :text
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
