class ImporterController < ApplicationController

  require 'csv'

  def index

  end

  def csv_import
     # http://satishonrails.wordpress.com/2007/07/18/how-to-import-csv-file-in-rails/
     @parsed_file=CSV::Reader.parse(params[:dump][:file])
     n=0
     @parsed_file.each  do |row|
     @user=User.new
     @user.name = row[0]
     @user.login = row[1]
     @user.email = row[2]
     @user.password = row[3]
     @user.password_confirmation = row[3]
     @user.participant = true
     if @user.save
      n=n+1
      GC.start if n%50==0
     end
     end
     flash.now[:notice]="CSV Import Successful,  #{n} new records added to data base"
  end
  
end