class CreateAttributes < ActiveRecord::Migration
  def self.up
    create_table :attributes do |t|
      t.column :field_1,    :string
      t.column :field_2,    :string
      t.column :field_3,    :string
      t.column :field_4,    :string
      t.column :field_5,    :string
      t.column :field_6,    :string
      t.column :field_7,    :string
      t.column :field_8,    :string
      t.column :field_9,    :string
      t.column :field_10,   :string
      t.column :user_id,    :integer
      t.column :project_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :attributes
  end
end
