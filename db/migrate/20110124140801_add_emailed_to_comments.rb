class AddEmailedToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :emailed, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :emailed
  end
end
