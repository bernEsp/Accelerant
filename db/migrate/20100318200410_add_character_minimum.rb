class AddCharacterMinimum < ActiveRecord::Migration
  def self.up
    add_column :projects, :character_minimum, :integer, :default => 0
  end

  def self.down
    remove_column :projects, :character_minimum
  end
end
