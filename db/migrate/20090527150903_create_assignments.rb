class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.column :title,                      :string, :limit => 255
      t.column :description,                :text
      t.column :project_id,                  :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
