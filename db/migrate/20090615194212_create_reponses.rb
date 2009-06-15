class CreateReponses < ActiveRecord::Migration
  def self.up
    create_table :reponses do |t|
      t.column :content,                   :text
      t.column :comment_id,                :integer
      t.column :user_id,                   :integer
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :reponses
  end
end
