class Addmediatodiscussions < ActiveRecord::Migration
def self.up
    add_column :discussions, :media_file_name,    :string
    add_column :discussions, :media_content_type, :string
    add_column :discussions, :media_file_size,    :integer
    add_column :discussions, :media_updated_at,   :datetime
  end

  def self.down
    remove_column :discussions, :media_file_name
    remove_column :discussions, :media_content_type
    remove_column :discussions, :media_file_size
    remove_column :discussions, :media_updated_at
  end
end
