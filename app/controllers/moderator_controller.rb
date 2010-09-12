class ModeratorController < ApplicationController
  before_filter :login_required
  
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index
  end

  def index
    @these_projects = Project.find(:all, :conditions => {:moderator_id => self.current_user.id })

    @last_ass = Project.find(:last, :conditions => {:moderator_id => self.current_user.id })
    @ass = Project.find(@last_ass.id)
    @theme = Themes.find(@ass.theme)

    unless @theme.nil?
      session[:theme] = @theme.id
    else
      session[:theme] = nil
    end

    
  end
end
