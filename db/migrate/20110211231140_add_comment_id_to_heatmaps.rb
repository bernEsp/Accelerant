class AddCommentIdToHeatmaps < ActiveRecord::Migration
  def self.up
    add_column :heatmaps, :comment_id,  :integer
  end

  def self.down
    remove_column :heatmaps, :comment_id
  end
end
