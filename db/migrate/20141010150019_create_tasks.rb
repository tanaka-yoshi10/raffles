class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.references :project, index: true

      t.timestamps
    end
  end
end
