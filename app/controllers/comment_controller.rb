class CommentController < ApplicationController
  uses_yui_editor
  require 'csv'
  def index
    user_id = self.current_user.id
    @comment = Comment.find(:all, :conditions => { :user_id => user_id})
  end
  
  def show
    @user_data = User.find(params[:id])
    @comments = Comment.find(:all, :conditions => ["project_id is NOT NULL and user_id = ?", params[:id]], :order => "project_id DESC, id DESC", :include => :project)
  end

  def new
    user_id = self.current_user.id
    #@comment = Comment.find(:all)
    #@comment = Comment.new
    #@latest_postings = Comment.find(:all, :limit => 20, :order => "id DESC")
    @your_assignments = UserAssignments.find(:all, :conditions => { :user_id => user_id})
  end

  def create
    puts "Updating..."
    @comment = Comment.new(params[:comment])
    @comment.save
    #redirect_to  "/comment/new"
    render :text => @comment.comment
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end
  
  def csv_dump
    respond_to do |format|
      format.csv { render :csv => Comment.find(:all, :conditions => {:project_id => params[:id] }, :order => "id DESC", :include => :user) }
    end
  end
  
  def export_to_csv
     comment = Comment.find(:all, :conditions => {:project_id => params[:id] }, :order => "id DESC", :include => :user)
     report = StringIO.new
        CSV::Writer.generate(report, ',') do |title|
          title << ['Comment','User','Posted']
          comment.each do |c|
            title << [c.comment,c.user.name,c.created_at]
            @replies = Replies.find(:all, :conditions => {:comment_id => c.id }, :order => "id DESC", :include => :user)
            @replies.each do |c|
              title << ['Reply-->'+c.content,c.user.name,c.created_at]
            end
          end
        end
       report.rewind
       #send_data(report.read,:type=>'text/csv;charset=iso-8859-1;
       #header=present',:filename=>'report.csv',
       #:disposition =>'attachment', :encoding => 'utf8')
       send_data(report.read,:type=>'text/csv;charset=iso-8859-1;',:filename=>'report.csv',
       :disposition =>'inline')
    end
  
end
