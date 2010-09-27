class AddPositionToSortableitems < ActiveRecord::Migration
  def self.up
    add_column :sortableitems, :position, :integer
  end

  def self.down
    remove_column :sortableitems, :position
  end
end
