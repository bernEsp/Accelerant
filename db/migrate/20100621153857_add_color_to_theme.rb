class AddColorToTheme < ActiveRecord::Migration
  def self.up
    add_column :themes, :color, :string
  end

  def self.down
    remove_column :themes, :color
  end
end
