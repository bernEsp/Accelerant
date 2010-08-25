class DiscussionController < ApplicationController
  before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :show, :new, :create, :edit, :update, :delete
  end

  def new
    @discussion = Discussion.new
    @comment_assignment = CommentAssignments.new
  end

  def delete
    @discussion = Discussion.find(params[:id])
    project = @discussion.project_id
    @discussion.destroy
    redirect_to :controller => 'assignment', :action => 'show', :id => project
  end

  def create
    @discussion = Discussion.new(params[:discussion])
    @discussion.save
    #new stuff
      if self.current_user.admin? || self.current_user.moderator?
      @user_assignments = params[:comment_assignment]
      if @user_assignments
        @these_keys = @user_assignments.keys
        @user_assignments.each do |key, value|
          if value=="0"
            @comment_assignment = CommentAssignments.new
            @comment_assignment.update_attributes(:user_id => key, :discussion_id => @discussion.id)
            @comment_assignment.save
          end
      end
      end
    end
    redirect_to "/assignment/#{@discussion.project_id}"
  end

  def show
    @project_members = UserAssignments.find(:all, :conditions => {:project_id => params[:project_id]}, :include => :user)
    #@project = Project.find(:all, :conditions => {:id => params[:project_id]})
    @project = Project.find(params[:project_id])
    @discussions = Discussion.find(:all, :conditions => {:project_id => params[:project_id]})
    unless params[:sort] == "by_user"
      @discussion = Discussion.find(params[:id])
    else
      @discussion = Discussion.find(params[:id])
    end
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def update
     @discussion = Discussion.find(params[:id])
     @discussion.update_attributes(params[:discussion])
    redirect_to :controller => 'assignment', :action => 'show', :id => @discussion.project_id
  end

end
