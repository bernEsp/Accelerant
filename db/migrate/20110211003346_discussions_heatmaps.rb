class DiscussionsHeatmaps < ActiveRecord::Migration
  def self.up
    create_table :discussions_heatmaps, :force => true, :id => false do |t|
      t.integer :discussion_id
      t.integer :heatmap_id
      t.timestamps
    end
  end

  def self.down
   drop_table :discussions_heatmaps
  end
end
