class CreateHeatmaps < ActiveRecord::Migration
  def self.up
    create_table :heatmaps do |t|
      t.column  :image_result,              :string
      t.column  :user_id,                   :integer
      t.column  :discussion_id,              :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :heatmaps
  end
end
