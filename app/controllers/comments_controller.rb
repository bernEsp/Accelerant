class CommentsController < ApplicationController
  def index
    user_id = self.current_user.id
    @comments = Comment.find(:all,:conditions => { :user_id => user_id})
  end
  
  def show
    user_id = self.current_user.id
    @comments = Comment.find(:all, :conditions => { :user_id => user_id})
  end

  def new
    @comment = Comment.find(:all)
    @comment = Comment.new
    @comment_assignment = CommentAssignments.new
  end
  
  def get
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comments])
    discussion.id = params[:comments][:discussion_id]
    project.id = params[:comments][:project_id]
    @comment.save
    #new stuff
      #if self.current_user.admin
      #@user_assignments = params[:comment_assignment]
      #@these_keys = @user_assignments.keys
      #@user_assignments.each do |key, value|
        #if value=="0"
          #@comment_assignment = CommentAssignments.new
          #@comment_assignment.update_attributes(:user_id => key, :comment_id => @comment.id)
          #@comment_assignment.save
        #end
      #end
    #end
    redirect_to "/discussion/show/#{discussion_id}?project_id=#{project_id}"
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end
  
end
