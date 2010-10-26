class CreateGroupables < ActiveRecord::Migration
  def self.up
    create_table :groupables do |t|
      t.column  :title,   :text
      t.column  :project_id,  :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :groupables
  end
end
