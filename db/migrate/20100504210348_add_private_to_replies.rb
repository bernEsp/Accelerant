class AddPrivateToReplies < ActiveRecord::Migration
  def self.up
    add_column :replies, :private,    :boolean, :default => false
  end

  def self.down
    remove_column :replies, :private
  end
end
