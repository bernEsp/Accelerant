class CreateUsersortables < ActiveRecord::Migration
  def self.up
    create_table :usersortables do |t|
      t.column :sortable, :integer
      t.column :sortableitem, :integer
      t.column :user, :integer
      t.column :position, :integer

      t.timestamps
    end
  end

  def self.down
    drop_table :usersortables
  end
end
