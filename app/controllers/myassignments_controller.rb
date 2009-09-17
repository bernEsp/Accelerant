class MyassignmentsController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
  end

  def show
    @your_assignments = UserAssignments.find(:all, :conditions => { :user_id => self.current_user.id})
  end
  
end
