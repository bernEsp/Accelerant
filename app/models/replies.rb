class Replies < ActiveRecord::Base
  belongs_to :comments
  belongs_to :user
  belongs_to :discussion

  
  has_attached_file :media,
  :storage => :s3,
  :whiny => false,
  :whiny_thumbnails => false, 
  :styles => { :large => "300x300>", :medium => "100x100>", :small => "50x50>", :tiny => "20x20>" },
  :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
  :path => ":attachment/:id/:style/:filename"
end
