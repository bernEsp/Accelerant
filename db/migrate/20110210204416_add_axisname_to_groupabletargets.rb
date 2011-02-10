class AddAxisnameToGroupabletargets < ActiveRecord::Migration
  def self.up
    add_column :groupabletargets, :axisname, :text
  end

  def self.down
    remove_column :groupabletargets, :axisname
  end
end
