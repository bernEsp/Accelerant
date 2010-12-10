class ModeratorController < ApplicationController
  before_filter :login_required
  
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index
  end

  def index
    @these_projects = Project.find(:all, :conditions => {:moderator_id => self.current_user.id })
    

    
  end
end
