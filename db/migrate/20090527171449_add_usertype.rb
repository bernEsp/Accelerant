class AddUsertype < ActiveRecord::Migration
  def self.up
    add_column :users, :participant, :boolean, :default => false
    add_column :users, :client, :boolean, :default => false
    add_column :users, :moderator, :boolean, :default => false
  end

  def self.down
    remove_column :users, :participant
    remove_column :users, :client
    remove_column :users, :moderator
  end
end
