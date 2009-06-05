class MyassignmentsController < ApplicationController
  
  def show
    user_id = self.current_user.id
    @your_assignments = UserAssignments.find(:all, :conditions => { :user_id => user_id})
  end
  
end
