class AddLock < ActiveRecord::Migration
  def self.up
    add_column :projects, :lock, :boolean, :default => false
  end

  def self.down
    remove_column :projects, :lock
  end
end
