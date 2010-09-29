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
          #if value=="0"
            if value !="0"
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
    unless @discussion.sortable.nil?
    @sortable = Sortables.find(@discussion.sortable)
    unless @sortable.nil?
      @usersortables = Usersortables.find_all_by_sortable(@sortable.id, :conditions => {:user => self.current_user.id}, :order => "position ASC" )
      if @usersortables.empty?
        @sortableitems = Sortableitems.find_all_by_sortables(@sortable.id)
        for sortableitem in @sortableitems
          @newusersortable = Usersortables.new
          @newusersortable.user = self.current_user.id
          @newusersortable.sortableitem = sortableitem.id
          @newusersortable.sortable = sortableitem.sortables
          @newusersortable.save
          @usersortables = Usersortables.find_all_by_sortable(@sortable.id, :conditions => {:user => self.current_user.id}, :order => "position ASC" )
        end
      end
    end
    end
  end

  def edit
    
    @discussion = Discussion.find(params[:id])
    @project_members = UserAssignments.find(:all, :conditions => {:project_id => @discussion.project_id}, :include => :user)
  end

  def update
     @discussion = Discussion.find(params[:id])
     @discussion.update_attributes(params[:discussion])
         #new stuff
      if self.current_user.admin? || self.current_user.moderator?
      @user_assignments = params[:comment_assignment]
      if @user_assignments
        @these_keys = @user_assignments.keys
        @user_assignments.each do |key, value|
          #if value=="0"
            if value !="0"
            @comment_assignment = CommentAssignments.new
            @comment_assignment.update_attributes(:user_id => key, :discussion_id => @discussion.id)
            @comment_assignment.save
          end
      end
      end
    end
    redirect_to :controller => 'assignment', :action => 'show', :id => @discussion.project_id
  end

end
