class CreateGroupableitems < ActiveRecord::Migration
  def self.up
    create_table :groupableitems do |t|
      t.column  :description,         :text
      t.column  :groupables,         :integer
      t.column  :position,            :integer
      t.column  :image_file_name,    :string
      t.column  :image_content_type, :string
      t.column  :image_file_size,    :integer
      t.column  :image_updated_at,   :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :groupableitems
  end
end
