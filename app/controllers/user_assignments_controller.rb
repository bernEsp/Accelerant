class UserAssignmentsController < ApplicationController
  
  def new
    @user_assignment = UserAssignments.new
  end
  
  def assign
    assignment_num = params[:id]
    puts assignment_num
    @user_assignments = params[:user_assignment]
    @these_keys = @user_assignments.keys
    @user_assignments.each do |key, value|
      unless value=="0"
        @user_assignment = UserAssignments.new
        @user_assignment.update_attributes(:user_id => value, :assignment_id => assignment_num)
        @user_assignment.save
      end
    end
    redirect_to  "/assignment"
  end
end
