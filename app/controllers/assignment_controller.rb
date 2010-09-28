class AssignmentController < ApplicationController
  before_filter :login_required
  
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
  end

  def index
    @all_assignment = Project.find(:all)
  end
  
  def new
    @new_assignment = Assignment.find(:all)
    @new_assignment = Assignment.new
  end
  
  def create
    @new_assignment = Assignment.new(params[:assignments])
    @new_assignment.save
    redirect_to "/project"
    #render :text => "Assignment Created!"
  end
  
  def edit
     @assignment_edit = Assignment.find(params[:id])
   end

   def update
     @assignment_edit = Assignment.find(params[:id])
     @assignment_edit.update_attributes(params[:assignment])
    redirect_to "/project"
   end
  
  def drop
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to "/assignment"
  end
  
  def assign
    @users = User.find(:all, :conditions => { :participant => true})
  end
  
  def user_assignments
    @user_assignments = User.find(:all, :conditions => { :participant => true})
  end
  
  def your_assignments
    user_id = self.current_user.id
    @user_assignments = User_assignments.find(:all, :conditions => {:user_id => user_id})
  end
  
  def show

    @project_members = UserAssignments.find(:all, :conditions => {:project_id => params[:id]}, :include => :user)
    #@project = Project.find(:all, :conditions => {:id => params[:id]})
    @project = Project.find(params[:id])
    @latest_postings = Comment.find(:all, :conditions => {:project_id => params[:id] }, :order => "id DESC", :include => :user)
    @discussions = Discussion.find(:all, :conditions => {:project_id => params[:id]}, :include => :user)
    @discussions_desc = Discussion.find(:first, :conditions => {:project_id => params[:id]}, :order => 'id DESC')
    unless @discussions_desc.sortable.nil?
    @sortable = Sortables.find(@discussions_desc.sortable)
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

  def show_spec
    @project_members = UserAssignments.find(:all, :conditions => {:project_id => params[:id]}, :include => :user)
    #@project = Project.find(:all, :conditions => {:id => params[:id]})
    @project = Project.find(params[:id])
    @latest_postings = Comment.find(:all, :conditions => {:project_id => params[:id] }, :order => "id DESC", :include => :user)
    @discussions = Discussion.find(:all, :conditions => {:project_id => params[:id]}, :include => :user)
    @discussions_desc = Discussion.find(:first, :conditions => {:project_id => params[:id]}, :order => 'id DESC')
  end
  

  
end
