class AddMediaToReplies < ActiveRecord::Migration
  def self.up
    add_column :replies, :media_file_name,    :string
    add_column :replies, :media_content_type, :string
    add_column :replies, :media_file_size,    :integer
    add_column :replies, :media_updated_at,   :datetime
  end

  def self.down
    remove_column :replies, :media_file_name
    remove_column :replies, :media_content_type
    remove_column :replies, :media_file_size
    remove_column :replies, :media_updated_at
  end
end
