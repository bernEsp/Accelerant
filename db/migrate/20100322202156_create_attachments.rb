class CreateAttachments < ActiveRecord::Migration
  def self.up
    drop_table :attachments
    
  end

  def self.down
    drop_table :attachments
  end
end
