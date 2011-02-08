class CreateUserImages < ActiveRecord::Migration
  def self.up
      create_table "user_images",:force => true do |t|
      t.column "user_id",      :integer
      t.column "primary",      :boolean
      t.column "created_at",   :datetime

      # Required attributes for attachment_fu plugin
      t.column "filename",     :string, :limit => 255
      t.column "path",         :string, :limit => 255
      t.column "content_type", :string
      t.column "size",         :integer
      t.column "width",        :integer
      t.column "height",       :integer
      t.column "parent_id",    :integer
      t.column "thumbnail",    :string
    end
  end

    def self.down
      drop_table :user_images
    end
end
