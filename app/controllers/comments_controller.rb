class CommentsController < ApplicationController
  before_filter :login_required

#  if ENV['RAILS_ENV'] == 'production'
#    ssl_required :index, :show, :update, :new, :create, :get, :destroy
#  end
  
  def index
    user_id = self.current_user.id
    @comments = Comment.find(:all,:conditions => { :user_id => user_id})
  end
  
  def show
    #user_id = self.current_user.id
    #@comments = Comment.find(:all, :conditions => { :user_id => user_id})
    @comment = Comment.find(params[:id])
  end

  def new
    #@comment = Comment.find(:all)
    @comment = Comment.new
   
  end
  
  def get
    @comment = Comment.new
  end

  def create
    if params[:comments]
      @discussion = Discussion.find(params[:comments][:discussion_id])
    end

    if @discussion.character_minimum.nil?
      @discussion.character_minimum = 0
      @discussion.save
    end
  
    if (@discussion.character_minimum == 0 || (@discussion.character_minimum != 0) && (params[:comments][:comment].length >= @discussion.character_minimum))
      @comment = Comment.new(params[:comments])
      @comment.save
      session[:comment_id] = @comment.id
      redirect_to "/discussion/show/#{@comment.discussion_id}?project_id=#{@comment.project_id}"
    else
      render :text => "Response is too short.  Must be #{@discussion.character_minimum} characters minimum."
    end
  end

  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end

  def update_report_flag
    @comment = Comment.find(params[:id])
    if @comment.for_report == 1
      @comment.for_report = 0
      @comment.save
      render :text => "Deleted of report"
    else
      @comment.for_report = 1
      @comment.save
      render :text => "Added of report"
    end
  end 

  def report_comments
    @discussion = Discussion.find(params[:id])
    @project = Project.find(@discussion.project_id)
    @comments = Comment.find(:all, :conditions => {:discussion_id => params[:id], :for_report => 1 }, :order => "created_at DESC", :include => :user)
  end

end
