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
    #user = User.find(:last, :conditions => {:id => self.current_user.id})
    redirect_to "/assignment/#{@assignment.project_id}"
    #render :text => @reply.content
    #puts params[:reply][:comment_id]
    #render :text => "<div id='subCommentForm#{params[:reply][:comment_id]}'></div><p style='background-color:#cdd7de;margin:8px;padding:2px;' id='reply#{@reply.id}'><img src='#{user.avatar.url(:smaller)}'%>&nbsp;&nbsp;&nbsp;&nbsp;#{@reply.content}<br/></p>"
  end
end
