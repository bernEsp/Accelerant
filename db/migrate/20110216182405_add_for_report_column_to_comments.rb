class AddForReportColumnToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :for_report,  :integer
  end

  def self.down
    remove_column :comments, :for_report
  end
end
