class AddSortableToDiscussions < ActiveRecord::Migration
  def self.up
    add_column :discussions, :sortable, :integer
  end

  def self.down
    remove_column :discussions, :sortable
  end
end
