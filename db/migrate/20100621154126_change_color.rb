class ChangeColor < ActiveRecord::Migration
  def self.up
    remove_column :themes, :color
    add_column :themes, :color, :string, :default => "07395a"
  end

  def self.down
    remove_column :themes, :color
  end
end
