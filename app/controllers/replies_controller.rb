class RepliesController < ApplicationController
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
    @reply = Replies.new(params[:reply])
    @reply.save
    @assignment = Comment.find(:last, :conditions => {:id => params[:reply][:comment_id]})
    redirect_to "/assignment/#{@assignment.assignment_id}"
    #render :text => @reply.content
  end
end
