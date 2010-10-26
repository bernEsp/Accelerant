class AddGroupableToDiscussions < ActiveRecord::Migration
  def self.up
    add_column :discussions, :groupable, :integer
  end

  def self.down
    remove_column :discussions, :groupable
  end
end
