class CreateDiscussions < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.column :title, :text
      t.column :content, :text
      t.column :project_id, :integer
      t.timestamps
    end

    add_column :comments, :discussion_id, :integer
    add_column :comment_assignments, :discussion_id, :integer
  end

  def self.down
    drop_table :discussions
    remove_column :comments, :discussion_id
    remove_column :comment_assignments, :discussion_id
  end
end
