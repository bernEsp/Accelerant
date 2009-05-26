class CommentsController < ApplicationController
  def index
      @comments = Comment.find(:all)
  end
  
  def show
      user_id = self.current_user.id
      @comments = Comment.find(:all, :conditions => { :user_id => user_id})
  end

  def new
    @comment = Comment.find(:all)
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comments])
    @comment.save
    #redirect_to  "/comment/new"
    render :text => "> > > Comment Logged"
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end
end
