class AssignmentController < ApplicationController
  
  def index
    @assignment = Assignment.find(:all)
  end
  
  def new
    @assignment = Assignment.find(:all)
    @assignment = Assignment.new
  end
  
  def create
    @assignment = Assignment.new(params[:assignments])
    @assignment.save
    #redirect_to  "/comment/new"
    render :text => "Assignment Created!"
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
    @assignment = Assignment.find(:all, :conditions => {:id => params[:id]})
    #user_id = self.current_user.id
    #@comment = Comment.find(:all)
    #@comment = Comment.new
    @latest_postings = Comment.find(:all, :conditions => {:assignment_id => params[:id] }, :limit => 20, :order => "id DESC")
  end
  
end
