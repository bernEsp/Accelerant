class AddHasHeatmapToDiscussion < ActiveRecord::Migration
  def self.up
    add_column :discussions, :has_heatmap,    :boolean
  end

  def self.down
    remove_column :discussions, :has_heatmap
  end
end
