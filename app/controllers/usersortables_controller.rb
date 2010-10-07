  class UsersortablesController < ApplicationController

  require 'csv'

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :sort, :csv
  end

  def sort
    params[:usersortables].each_with_index do |id, index|
      Usersortables.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  def csv
    @NumItems = Sortableitems.count(:all, :conditions => {:sortables => params[:id]})
    @Items = Sortableitems.find(:all, :conditions => {:sortables => params[:id]})
    report = StringIO.new
    CSV::Writer.generate(report, ',') do |lineofdata|
      for obj in @Items do
          #lineelement = obj.description
          lineelement = ""
          1.upto(@NumItems) { |n|
            #puts n
            lineelement = lineelement + ','
            lineelement = lineelement + Usersortables.count(:sortableitem, :conditions => {:sortableitem=> obj.id,:position => n}).to_s
          }
          lineofdata << [obj.description,lineelement]
      end
      report.rewind

      send_data(report.read,:type=>'text/csv;charset=iso-8859-1;',:filename=>'report.csv',
      :disposition =>'attachment', :encoding => 'utf8')
    end


     #comment = Comment.find(:all, :conditions => {:project_id => params[:id] }, :order => "id ASC", :include => :user)
     #report = StringIO.new
        #CSV::Writer.generate(report, ',') do |title|
          #title << ['Comment','User','Login','Date Posted','Time Posted']
          #comment.each do |c|
            #created = Date.parse(c.created_at.to_s).strftime("%m/%d/%Y")
            #c.comment = c.comment.gsub(/<\/?[^>]*>/,  "")
            #title << [c.comment,c.user.name,c.user.login,Date.parse(c.created_at.to_s).strftime("%m/%d/%Y"),Time.parse(c.created_at.to_s).strftime("%I:%M:%S")]
            #@replies = Replies.find(:all, :conditions => {:comment_id => c.id }, :order => "id ASC", :include => :user)
            #@replies.each do |d|
              #title << ['Reply-->' + d.content,d.user.name,d.user.login,Date.parse(d.created_at.to_s).strftime("%m/%d/%Y"),Time.parse(d.created_at.to_s).strftime("%I:%M:%S")]
            #end
          #end
        #end
       #report.rewind

       #send_data(report.read,:type=>'text/csv;charset=iso-8859-1;',:filename=>'report.csv',
       #:disposition =>'attachment', :encoding => 'utf8')
    end

  end