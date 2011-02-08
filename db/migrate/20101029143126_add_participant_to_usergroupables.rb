class AddParticipantToUsergroupables < ActiveRecord::Migration
  def self.up
    add_column :usergroupables, :participant, :boolean, :default => false
  end

  def self.down
    remove_column :usergroupables, :participant
  end
end
