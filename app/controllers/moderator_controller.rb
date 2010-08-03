class ModeratorController < ApplicationController
  before_filter :login_required
  def index
    @these_projects = Project.find(:all, :conditions => {:moderator_id => self.current_user.id })
  end
end
