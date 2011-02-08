class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.column :name, :string, :limit => 255
      t.column :address, :text
      t.column :city, :string, :limit => 255
      t.column :state, :string, :limit => 255
      t.column :zip, :string, :limit => 20
      t.column :country, :string, :limit => 2, :default => "US"
      t.column :phone, :string, :limit => 20
      t.column :fax, :string, :limit => 20
      t.timestamps
    end
    
    add_column :users, :company_id, :integer, :default => 0
  end

  def self.down
    drop_table :companies
    remove_column :users, :company_id
  end
end
