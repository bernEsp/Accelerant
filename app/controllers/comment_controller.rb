class CommentController < ApplicationController
  uses_yui_editor
  def index
    user_id = self.current_user.id
    @comment = Comment.find(:all, :conditions => { :user_id => user_id})
  end
  
  def show
    #user_id = self.current_user.id
    @comments = Comment.find(:all, :conditions => { :user_id => params[:id]}, :order => "id DESC")
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
end
