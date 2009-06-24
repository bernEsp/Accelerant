class MyassignmentsController < ApplicationController
  
  def show
    @your_assignments = UserAssignments.find(:all, :conditions => { :user_id => self.current_user.id})
  end
  
end
