class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.integer :duration

      t.timestamps
    end
  end
end
