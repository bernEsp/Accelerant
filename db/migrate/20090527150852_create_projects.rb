class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
        t.column :title,                      :string, :limit => 255
        t.column :description,                :text
        t.column :client_id,                  :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
