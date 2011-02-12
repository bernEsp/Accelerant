class CreateHeatmapCoords < ActiveRecord::Migration
  def self.up
    create_table :heatmap_coords do |t|
      t.column :heatmap_id,                 :integer
      t.column :coord_x,                    :float
      t.column :coord_y,                    :float
      t.column :coord_radio,                :float
      t.timestamps
    end
  end

  def self.down
    drop_table :heatmap_coords
  end
end
