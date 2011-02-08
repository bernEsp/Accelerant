class CreateUserAssignments < ActiveRecord::Migration
  def self.up
    create_table :user_assignments do |t|
      t.column :user_id,                        :integer
      t.column :assignment_id,                  :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :user_assignments
  end
end
