class AddOrientationToGroupableaxis < ActiveRecord::Migration
  def self.up
    add_column :groupableaxis, :orientation, :string
  end

  def self.down
    remove_column :groupableaxis, :orientation
  end
end
