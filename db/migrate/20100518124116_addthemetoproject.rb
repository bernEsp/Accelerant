class Addthemetoproject < ActiveRecord::Migration
  def self.up
    add_column :projects, :theme, :integer, :default => 1
  end

  def self.down
    remove_column :projects, :theme
  end
end
