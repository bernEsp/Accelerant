class Hiddenuntilanswered < ActiveRecord::Migration
  def self.up
    add_column :comments, :hide_until_answered, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :hide_until_answered
  end
end
