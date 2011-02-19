class AddPhoto < ActiveRecord::Migration
  def self.up
    add_column :comments, :data, :binary
  end

  def self.down
    remove_column :comments, :data
  end
end
