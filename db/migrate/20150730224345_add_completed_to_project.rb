class AddCompletedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :completed, :boolean, :null => false, :default => false
  end
end
