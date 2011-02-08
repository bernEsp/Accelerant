class AddGroupableaxisIdToGroupabletargets < ActiveRecord::Migration
  def self.up
    add_column :groupabletargets, :groupableaxis_id, :integer
  end

  def self.down
    remove_column :groupabletargets, :groupableaxis_id
  end
end
