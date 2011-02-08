class AddOrientationToGroupabletargets < ActiveRecord::Migration
  def self.up
    add_column :groupabletargets, :orientation, :string
  end

  def self.down
    remove_column :groupabletargets, :orientation
  end
end
