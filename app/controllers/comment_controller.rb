class CommentController < ApplicationController
  before_filter :login_required
  uses_yui_editor
  require 'csv'

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update,
      :drop, :assign, :show, :destroy, :csv_dump, :export_to_csv,
      :by_user, :email_assign, :emailed
  end

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
          title << ['Comment','User','Login','Date Posted','Time Posted']
          comment.each do |c|
            created = Date.parse(c.created_at.to_s).strftime("%m/%d/%Y")
            puts created
            title << [c.comment,c.user.name,c.user.login,Date.parse(c.created_at.to_s).strftime("%m/%d/%Y"),Time.parse(c.created_at.to_s).strftime("%I:%M:%S")]
            @replies = Replies.find(:all, :conditions => {:comment_id => c.id }, :order => "id DESC", :include => :user)
            @replies.each do |d|
              title << ['Reply-->' + d.content,d.user.name,d.user.login,Date.parse(d.created_at.to_s).strftime("%m/%d/%Y"),Time.parse(d.created_at.to_s).strftime("%I:%M:%S")]
            end
          end
        end
       report.rewind
       #send_data(report.read,:type=>'text/csv;charset=iso-8859-1;
       #header=present',:filename=>'report.csv',
       #:disposition =>'attachment', :encoding => 'utf8')
       send_data(report.read,:type=>'text/csv;charset=iso-8859-1;',:filename=>'report.csv',
       :disposition =>'attachment', :encoding => 'utf8')
    end

  def by_user
    @these_comments = Comment.belongs_to_discussion.find(:all, :conditions => { :user_id => params[:id]})
    @these_replies = Replies.find(:all, :conditions => {:user_id => params[:id]})
  end

  def emailed
    #email_parser.check_inbound
    @your_assignment = UserAssignments.find(:last, :conditions => { :user_id => self.current_user.id})
    @this_assignment = Project.find(:last, :conditions => {:id => @your_assignment.project_id})
    puts "shit"
    puts @your_assignment.project_id
    @emailed_comments = Comment.unassigned.find(:all, :conditions => { :user_id => self.current_user.id})
  end

  def email_assign
    
    @comment = Comment.find(params[:comment][:id])
    @discussion = Discussion.find(params[:discussion][:discussion_id])
    @comment.discussion_id = @discussion.id
    @comment.save
    render :text => "Comment has been assigned!"
  end
  
end
