class AddDiscussionIdToReplies < ActiveRecord::Migration
  def self.up
    add_column :replies, :discussion_id,    :integer
  end

  def self.down
    remove_column :replies, :discussion_id
  end
end
