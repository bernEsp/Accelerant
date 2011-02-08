class AddPhoto < ActiveRecord::Migration
  def self.up
    add_column :comments, :data, :binary, :limit => 1.megabyte
  end

  def self.down
    remove_column :comments, :data
  end
end
