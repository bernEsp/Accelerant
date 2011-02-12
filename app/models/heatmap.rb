class Heatmap < ActiveRecord::Base

  belongs_to :user
  belongs_to :discussion
  belongs_to :comment
  has_many :heatmap_coords

  def create_heatmap(image, coords, user_id, discussion_id){
    last_comment = Comment.find(:last,:conditions => [:user_id => user_id, :discussion_id => discussion_id])
    discussion = Discussion.find(discussion_id)
    heatmap = Heatmap.new(:image_result => image, :user_id => user_id,:comment_id => last_comment.id)
    if heatmap.save
       discussion.heatmaps << heatmap
       image_coords = []
       while coords.to_a.length >= 3
          image_coords == coords.slice!(0..2)
          image_coords.each do |coord|
            heatmap_coords = HeatmapCoord.new(:coord_x => coord[0], :coord_y => coord[1], :coord_radio => coord[2])
            heatmap.heatmap_coords << heatmap_coords  if heatmap_coords.save
          end
       end
       return true
    end
  }
end
