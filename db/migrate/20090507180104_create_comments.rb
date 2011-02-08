class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :title,                     :string, :limit => 255
      t.column :url,                       :string, :limit => 255
      t.column :comment,                   :text
      t.column :upload,                    :string, :limit => 255
      t.column :user_id,                   :integer
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
