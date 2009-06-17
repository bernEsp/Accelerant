class Comment < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", :small => "50x50>", :tiny => "20x20>" }
  
  #validates_format_of :content_type,
   #                   :with => /^image/,
    #                  :message => "-- you can only upload pictures"
                      
  def uploaded_picture=(picture_field)
    self.name         = base_part_of(picture_field.original_filename)
    self.content_type = picture_field.content_type.chomp
    self.data         = picture_field.read
  end
  
  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end
  
end
