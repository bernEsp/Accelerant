class Project < ActiveRecord::Base
  has_many :comments
  belongs_to :client
  
  has_attached_file :photo, :styles => { :large => "300x300>", :medium => "100x100>", :small => "50x50>", :tiny => "20x20>" },
  :whiny => false,
  :whiny_thumbnails => false
  
end