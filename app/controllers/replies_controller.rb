class RepliesController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :show, :get, :update, :new, :create
  end

  def index
    user_id = self.current_user.id
    @replies = Reply.find(:all,:conditions => { :user_id => user_id})
  end
  
  def new
    @reply = Replies.find(:all)
    @reply = Replies.new
  end
  
  def get
    @reply = Replies.new
  end

  def create
    @project = Project.find(params[:project_id])
    if (@project.character_minimum != 0) && (params[:reply][:content].length >= @project.character_minimum)
      @reply = Replies.new(params[:reply])
      @reply.save
      @comment = Comment.find(@reply.comment_id)
      @discussion = Discussion.find(@comment.discussion_id)
      @assignment = Comment.find(:last, :conditions => {:id => params[:reply][:comment_id]})
      redirect_to "/discussion/show/#{@discussion.id}?project_id=#{@project.id}#bottom"
    else
      render :text => "Response is too short.  Must be #{@project.character_minimum} characters minimum."
    end
  end

  def by_user
    @these_replies = Replies.find(:all, :conditions => { :user_id => params[:id]})
  end

end
