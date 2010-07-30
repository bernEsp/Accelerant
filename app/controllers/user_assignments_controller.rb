class UserAssignmentsController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
  end

  def new
    @user_assignment = UserAssignments.new
  end
  
  def assign
    project_num = params[:id]
    #puts project_num
    @user_assignments = params[:user_assignment]
    @these_keys = @user_assignments.keys
    @user_assignments.each do |key, value|
      unless value=="0"
        @user_assignment = UserAssignments.new
        @user_assignment.update_attributes(:user_id => value, :project_id => project_num)
        @user_assignment.save
      end
    end
    redirect_to  "/project"
  end
end
