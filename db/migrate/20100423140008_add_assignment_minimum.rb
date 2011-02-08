class AddAssignmentMinimum < ActiveRecord::Migration
  def self.up
    add_column :assignments, :character_minimum, :integer, :default => 0
  end

  def self.down
    remove_column :assignments, :character_minimum
  end
end
