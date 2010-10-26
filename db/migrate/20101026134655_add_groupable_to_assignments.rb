class AddGroupableToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :groupable, :integer
  end

  def self.down
    remove_column :assignments, :groupable
  end
end
