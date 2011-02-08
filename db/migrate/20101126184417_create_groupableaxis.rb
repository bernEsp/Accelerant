class CreateGroupableaxis < ActiveRecord::Migration
  def self.up
    create_table :groupableaxis do |t|
      t.column  :description,         :text
      t.column :groupable, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :groupableaxis
  end
end
