class Removeresponseboxhide < ActiveRecord::Migration
  def self.up
    remove_column :projects, :response_box_visible
  end

  def self.down
    add_column :projects, :response_box_visible, :integer, :default => true
  end
end
