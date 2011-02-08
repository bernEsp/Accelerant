class CommentsController < ApplicationController
  before_filter :login_required

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :show, :update, :new, :create, :get, :destroy
  end
  
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
    @discussion = Discussion.find(params[:comments][:discussion_id])
    if @discussion.character_minimum.nil?
      @discussion.character_minimum = 0
      @discussion.save
    end
    if (@discussion.character_minimum == 0 || (@discussion.character_minimum != 0) && (params[:comments][:comment].length >= @discussion.character_minimum))
      @comment = Comment.new(params[:comments])
      @comment.save
      #redirect_to "/discussion/show/#{@comment.discussion_id}?project_id=#{@comment.project_id}#bottom"
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

end