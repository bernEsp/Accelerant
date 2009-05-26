class CommentController < ApplicationController
  uses_yui_editor
  def index
      @comment = Comment.find(:all)
  end
  
  def show
    #user_id = self.current_user.id
    @comments = Comment.find(:all, :conditions => { :user_id => params[:id]})
  end

  def new
    @comment = Comment.find(:all)
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.save
    #redirect_to  "/comment/new"
    render :text => "Comment Logged"
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end
end
