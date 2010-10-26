class CreateUsergroupables < ActiveRecord::Migration
  def self.up
    create_table :usergroupables do |t|
      t.column :groupable, :integer
      t.column :groupableitem, :integer
      t.column :user, :integer
      t.column :position, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :usergroupables
  end
end
