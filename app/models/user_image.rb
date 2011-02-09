class UserImage < ActiveRecord::Base
  belongs_to :user

    has_attachment  :content_type => :image,
      :storage => :s3,
      :min_size => 0,
      :max_size => 3.megabytes,
      :resize_to => '640x480',
      :thumbnails => { :medium => '200x200', :small => '80x80', :tiny => '40x40' },
      :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml"

    # Override the default AttachmentFu error messages.
    def validate
      if filename.nil?
        errors.add_to_base("You must choose a file to upload")
      else
        # Images should only be GIF, JPEG, or PNG
        enum = attachment_options[:content_type]
        unless enum.nil? || enum.include?(send(:content_type))
          errors.add_to_base("You can only upload images (GIF, JPEG, or PNG)")
        end
        # Images should be less than UPLOAD_LIMIT MB.
        enum = attachment_options[:size]
        unless enum.nil? || enum.include?(send(:size))
          msg = "Images should be smaller than 1 MB"
          errors.add_to_base(msg)
        end
      end
    end
end
