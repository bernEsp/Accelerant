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
<<<<<<< HEAD
=======
    unless @discussions.nil?
      session[:discussion_id] = Discussion.find(:last)
    end
>>>>>>> 01338ef24515822ab28e24158bdbcad5d4dc024f
    unless !@discussions_desc || @discussions_desc.sortable.nil?
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
          if self.current_user.participant
            @newusersortable.participant = true
          else
            @newusersortable.participant = false
          end
          @newusersortable.save
          @usersortables = Usersortables.find_all_by_sortable(@sortable.id, :conditions => {:user => self.current_user.id}, :order => "position ASC" )
        end
      else
        for usersorts in @usersortables
          if self.current_user.participant
            usersorts.participant = true
            usersorts.save
          end
        end
      end
    end
    end

    unless !@discussions_desc || @discussions_desc.groupable.nil?
    @groupable = Groupables.find(@discussions_desc.groupable)
    @groupabletargets = Groupabletargets.find_all_by_groupable(@groupable.id, :order => "id DESC")
    unless @groupable.nil?
      @usergroupables = Usergroupables.find_all_by_groupable(@groupable.id, :conditions => {:user => self.current_user.id} )
      if @usergroupables.empty?
        @groupableitems = Groupableitems.find_all_by_groupables(@groupable.id)
        for groupableitem in @groupableitems
          @newusergroupable = Usergroupables.new
          @newusergroupable.user = self.current_user.id
          @newusergroupable.groupableitem = groupableitem.id
          @newusergroupable.groupable = groupableitem.groupables
          if self.current_user.participant
            @newusergroupable.participant = true
          else
            @newusergroupable.participant = false
          end
          @newusergroupable.save
          @usergroupables = Usergroupables.find_all_by_groupable(@groupable.id, :conditions => {:user => self.current_user.id})
        end
      else
        for usergroups in @usergroupables
          if self.current_user.participant
            puts "woopee"
            usergroups.participant = true
            usergroups.save
          end
          puts "found some"
        end
      end
    end
    end
  end
<<<<<<< HEAD

=======
  
    
>>>>>>> 01338ef24515822ab28e24158bdbcad5d4dc024f
  def show_spec
    @project_members = UserAssignments.find(:all, :conditions => {:project_id => params[:id]}, :include => :user)
    #@project = Project.find(:all, :conditions => {:id => params[:id]})
    @project = Project.find(params[:id])
    @latest_postings = Comment.find(:all, :conditions => {:project_id => params[:id] }, :order => "id DESC", :include => :user)
    @discussions = Discussion.find(:all, :conditions => {:project_id => params[:id]}, :include => :user)
    @discussions_desc = Discussion.find(:first, :conditions => {:project_id => params[:id]}, :order => 'id DESC')
  end
  

  
end
