class CreateFollowUps < ActiveRecord::Migration
  def self.up
    create_table :follow_ups do |t|
      t.column :user_id,                    :integer
      t.column :reply_id,                   :integer
      t.column :reply_belongs_to,           :integer
      t.column :content,                    :text
      t.timestamps
    end
  end

  def self.down
    drop_table :follow_ups
  end
end
