class AddModeratorIdToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :moderator_id,    :integer
  end

  def self.down
    remove_column :projects, :moderator_id
  end
end
