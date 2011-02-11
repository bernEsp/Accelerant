class CreateHeatmapCoords < ActiveRecord::Migration
  def self.up
    create_table :heatmap_coords do |t|
      t.column :heatmap_id,                 :interger
      t.column :coord_x,                    :decimal
      t.column :coord_y,                    :decimal
      t.column :coord_radio,                :decimal
      t.timestamps
    end
  end

  def self.down
    drop_table :heatmap_coords
  end
end
