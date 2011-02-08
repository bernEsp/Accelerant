class Addresponsebox < ActiveRecord::Migration
  def self.up
    add_column :projects, :response_box, :boolean, :default => true
  end

  def self.down
    remove_column :projects, :response_box
  end
end
