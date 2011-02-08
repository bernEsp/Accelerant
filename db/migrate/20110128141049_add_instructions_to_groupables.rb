class AddInstructionsToGroupables < ActiveRecord::Migration
  def self.up
    add_column :groupables, :instructions, :text
  end

  def self.down
    remove_column :groupables, :instructions
  end
end
