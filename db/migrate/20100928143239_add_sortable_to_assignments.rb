class AddSortableToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :sortable, :integer
  end

  def self.down
    remove_column :assignments, :sortable
  end
end
