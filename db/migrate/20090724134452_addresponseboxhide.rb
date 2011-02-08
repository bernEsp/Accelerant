class Addresponseboxhide < ActiveRecord::Migration
  def self.up
    add_column :projects, :response_box_visible, :integer, :default => true
  end

  def self.down
    remove_column :projects, :response_box_visible
  end
end
