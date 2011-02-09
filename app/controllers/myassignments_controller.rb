class MyassignmentsController < ApplicationController
  before_filter :login_required
#  if ENV['RAILS_ENV'] == 'production'
#    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
#  end

  def show
    @your_assignments = UserAssignments.find(:all, :conditions => { :user_id => self.current_user.id}, :group => "project_id, id")
    @last_ass = UserAssignments.find(:last, :conditions => { :user_id => self.current_user.id})
    @ass = Project.find(@last_ass.project_id)
    @theme = Themes.find(@ass.theme)
    
    unless @theme.nil?
      session[:theme] = @theme.id
    else
      session[:theme] = nil
    end
  end
  
end
