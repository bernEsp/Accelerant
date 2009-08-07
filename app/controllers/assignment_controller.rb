class AssignmentController < ApplicationController
  
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
    @project = Project.find(:all, :conditions => {:id => params[:id]})
    @latest_postings = Comment.find(:all, :conditions => {:project_id => params[:id] }, :limit => 20, :order => "id DESC", :include => :user)
    
    @discussions = Discussion.find(:all, :conditions => {:project_id => params[:id]}, :include => :user)
    @discussions_desc = Discussion.find(:first, :conditions => {:project_id => params[:id]}, :order => 'id DESC')
  end
  

  
end
