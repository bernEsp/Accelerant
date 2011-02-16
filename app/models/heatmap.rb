class Heatmap < ActiveRecord::Base
  require 'tmpdir'
  belongs_to :user
  belongs_to :discussion
  belongs_to :comment
  has_many :heatmap_coords

  def self.create_heatmap(image, coords, user_id, discussion_id)
    discussion = Discussion.find(discussion_id)
    user = User.find(user_id)
    heatmap = Heatmap.new(:image_result => image, :user_id => user.id)
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

  def self.create_tmp_image(discussion_id, user_id)

    heatmap = Heatmap..find(:last, :conditions => {:user_id => self.current_user.id})
    binaryData = Base64.decode64(heatmap.image_result)
    f = Tempfile.new("#{discussion.id}_heatmap_image#{heatmap.id}.jpg")
    f.open("#{discussion.id}_heatmap_image#{heatmap.id}.jpg"){ |a| a.write(binaryData) }
    path =  f.path
    f.close
    return path
#    File.open("#{RAILS_ROOT}/public/tmp/#{discussion.id}_heatmap_image#{heatmap.id}.jpg", "wb") { |f| f.write(binaryData) }
#    render :text => "success"
  end
end
