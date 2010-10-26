class CreateGroupabletargets < ActiveRecord::Migration
  def self.up
    create_table :groupabletargets do |t|
      t.column  :description,         :text
      t.column :groupable, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :groupabletargets
  end
end
