class CreateCommentAssignments < ActiveRecord::Migration
  def self.up
    create_table :comment_assignments do |t|
      t.column :user_id,                        :integer
      t.column :comment_id,                     :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :comment_assignments
  end
end
