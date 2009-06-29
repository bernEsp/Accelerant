class AddOneToOneToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :one_to_one,    :boolean, :default => false
  end

  def self.down
    remove_column :projects, :one_to_one
  end
end
