class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :comment_assignment
  
  has_attached_file :photo, 
  :styles => { :medium => "300x300>", :thumb => "100x100>", :small => "50x50>", :tiny => "20x20>" }, 
  :whiny => false,
  :whiny_thumbnails => false
  
  comma do

      project :title
      comment
      user :name
      created_at

      #pages :size => 'Pages'
      #publisher :name
      #isbn :number_10 => 'ISBN-10', :number_13 => 'ISBN-13'
      #blurb 'Summary'

    end
  
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
