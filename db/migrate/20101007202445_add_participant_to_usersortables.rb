class AddParticipantToUsersortables < ActiveRecord::Migration
  def self.up
    add_column :usersortables, :participant, :boolean, :default => false
  end

  def self.down
    remove_column :usersortables, :participant
  end
end
