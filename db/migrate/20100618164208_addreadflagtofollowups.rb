class Addreadflagtofollowups < ActiveRecord::Migration
  def self.up
    add_column :follow_ups, :read,    :boolean
  end

  def self.down
    remove_column :follow_ups, :read
  end
end
