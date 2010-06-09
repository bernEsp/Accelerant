class Additionaluserattributes < ActiveRecord::Migration
  def self.up
    add_column :users, :field_1,    :string
    add_column :users, :field_2,    :string
    add_column :users, :field_3,    :string
    add_column :users, :field_4,    :string
    add_column :users, :field_5,    :string
    add_column :users, :field_6,    :string
    add_column :users, :field_7,    :string
    add_column :users, :field_8,    :string
    add_column :users, :field_9,    :string
    add_column :users, :field_10,    :string
  end

  def self.down
    remove_column :users, :field_1
    remove_column :users, :field_2
    remove_column :users, :field_3
    remove_column :users, :field_4
    remove_column :users, :field_5
    remove_column :users, :field_6
    remove_column :users, :field_7
    remove_column :users, :field_8
    remove_column :users, :field_9
    remove_column :users, :field_10
  end
end
