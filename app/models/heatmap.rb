class Heatmap < ActiveRecord::Base

  belongs_to :user
  belongs_to :discussion
  belongs_to :comment
  has_many :heatmap_coords

  def self.create_heatmap(image, coords, user_id, discussion_id)
    discussion = Discussion.find(discussion_id)
    heatmap = Heatmap.new(:image_result => image, :user_id => user_id, :comment_id => last_comment.id)
    if heatmap.save
       discussion.heatmaps << heatmap
       image_coords = []
       coords = coords.split(",")
       while coords.length >= 3
          coord = coords.slice!(0..2)
          heatmap_coords = HeatmapCoord.new(:coord_x => coord[0], :coord_y => coord[1], :coord_radio => coord[2])
          heatmap.heatmap_coords << heatmap_coords  if heatmap_coords.save

       end
       true
    end
  end
end
