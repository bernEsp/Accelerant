class CommentController < ApplicationController
  uses_yui_editor
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
  
end
