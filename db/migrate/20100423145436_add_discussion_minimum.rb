class AddDiscussionMinimum < ActiveRecord::Migration
  def self.up
    add_column :discussions, :character_minimum, :integer, :default => 0
    remove_column :assignments, :character_minimum
    remove_column :projects, :character_minimum
  end

  def self.down
    remove_column :discussions, :character_minimum
  end
end
