class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
  belongs_to :comment_assignment

  # for paperclip (polymorphic)
  #acts_as_polymorphic_paperclip

  named_scope :is_moderator, :joins => :users, :conditions => ['user.moderator = ?', true]
  named_scope :is_admin, :joins => :users, :conditions => ['user.admin = ?', true]
  named_scope :belongs_to_discussion, :conditions => ['discussion_id IS NOT NULL']
  named_scope :unassigned, :conditions => ['discussion_id IS NULL']

  #has_many :attachings, :dependent => :destroy
  #has_many :attachments

  has_attached_file :photo,
  :storage => :s3,
  :whiny => false, 
  :whiny_thumbnails => false, 
  :styles => { :medium => "300x300>", :thumb => "100x100>", :small => "50x50>", :tiny => "20x20>" },
  :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml"

  comma do
      project :title
      comment
      user :nam
      created_at
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
