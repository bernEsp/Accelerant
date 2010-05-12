class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.column :name, :string
      t.timestamps
    end
    Themes.create(:name => 'default')
  end

  def self.down
    drop_table :themes
  end
end
