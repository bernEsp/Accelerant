class CreateHeatmapCoords < ActiveRecord::Migration
  def self.up
    create_table :heatmap_coords do |t|
      t.column :coord_x,       :double
      t.column :coord_y,       :double
      t.column :coord_radio,   :double
      t.column :heatmap_id,    :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :heatmap_coords
  end
end
