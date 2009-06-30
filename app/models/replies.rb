class Replies < ActiveRecord::Base
  belongs_to :comments
  belongs_to :user
  
  has_attached_file :media, 
  :whiny => false,
  :whiny_thumbnails => false, 
  :styles => { :large => "300x300>", :medium => "100x100>", :small => "50x50>", :tiny => "20x20>" }
  
end
