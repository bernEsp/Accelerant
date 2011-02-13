class Discussion < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :heatmaps
  
  #named_scope :is_last, :conditions => {:is_published => true}


  has_attached_file :media,
  :storage => :s3,
  :whiny => false,
  :whiny_thumbnails => false,
  :styles => { :large => "300x300>", :medium => "100x100>", :small => "50x50>", :tiny => "20x20>" },
  :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
  :path => ":attachment/:id/:style/:filename"

  def self.create_xml(user, discussion)
    if user.client 
       xml_data = []
       xml_data << {:user_name => user.name, :user_id => user.id, :admin => user_criteria(user), :image_path => discussion.media.url, :discussion_id => discussion.id }
       xml_data
    else
      heatmaps = discussion.heatmaps
      xml_data = []
      xml_data << {:user_name => user.name, :user_id => user.id, :admin => user_criteria(user), :image_path => discussion.media.url, :discussion_id => discussion.id }
      heatmaps.each do |heatmap|
        xml_data <<  heatmap.heatmap_coords
      end
      xml_data = xml_data.flatten
    end
  end

  def self.user_criteria(user)
    if user.admin || user.moderator || user.client
      true
    else 
      false
    end
  end

end
