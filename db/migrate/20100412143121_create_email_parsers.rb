class CreateEmailParsers < ActiveRecord::Migration
  def self.up
    create_table :email_parsers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :email_parsers
  end
end
