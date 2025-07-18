class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
