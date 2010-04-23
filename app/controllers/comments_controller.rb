class CommentsController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :show, :update, :new, :create
  end
  
  def index
    user_id = self.current_user.id
    @comments = Comment.find(:all,:conditions => { :user_id => user_id})
  end
  
  def show
    user_id = self.current_user.id
    @comments = Comment.find(:all, :conditions => { :user_id => user_id})
  end

  def new
    #@comment = Comment.find(:all)
    @comment = Comment.new
   
  end
  
  def get
    @comment = Comment.new
  end

  def create
    #@project = Project.find(params[:comments][:project_id])
    #if (@project.character_minimum == 0 || (@project.character_minimum != 0) && (params[:comments][:comment].length >= @project.character_minimum))
      #@comment = Comment.new(params[:comments])
      #@comment.save
      #redirect_to "/discussion/show/#{@comment.discussion_id}?project_id=#{@comment.project_id}#bottom"
    #else
      #render :text => "Response is too short.  Must be #{@project.character_minimum} characters minimum."
    #end

    @discussion = Discussion.find(params[:comments][:discussion_id])
    if (@discussion.character_minimum == 0 || (@discussion.character_minimum != 0) && (params[:comments][:comment].length >= @discussion.character_minimum))
      @comment = Comment.new(params[:comments])
      @comment.save
      redirect_to "/discussion/show/#{@comment.discussion_id}?project_id=#{@comment.project_id}#bottom"
    else
      render :text => "Response is too short.  Must be #{@discussion.character_minimum} characters minimum."
    end

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
  end

  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end

  
end
