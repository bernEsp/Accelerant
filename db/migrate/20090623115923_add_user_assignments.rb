class AddUserAssignments < ActiveRecord::Migration
  def self.up
    add_column :user_assignments, :project_id,    :integer
  end

  def self.down
    remove_column :user_assignemnts, :project_id
  end
end
