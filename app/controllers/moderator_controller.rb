class ModeratorController < ApplicationController
  def index
    @these_projects = Project.find(:all)
  end
end
