class ProjectController < ApplicationController
  before_filter :login_required

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :drop
  end

  def index
    cookies.to_hash.each_pair do |k, v|
      if cookies[k.to_sym].split('_')[0] == "field"
        cookies.delete(k.to_sym)
      end
    end
    cookies.delete(:filter)
    @these_projects = Project.find(:all)
  end
  
  def new
    @this_project = Project.find(:all)
    @this_project = Project.new
  end
  
  def create
    @this_project = Project.new(params[:projects])
    @this_project.save
    redirect_to  "/project"
    #render :text => "Project Created!"
  end
  
  def edit
    @this_project = Project.find(params[:id])
    @sortables = Sortables.find_all_by_project_id(params[:id])
    @groupables = Groupables.find_all_by_project_id(params[:id])
  end
  
  def update
    @this_project = Project.find(params[:id])
    @this_project.update_attributes(params[:project])
    @this_project.update_attributes(params[:this_project])
    if self.current_user.admin
      redirect_to "/project"
    end
    if self.current_user.moderator
      redirect_to "/moderator"
    end
  end
  
  def drop
    @this_project = Project.find(params[:id])
    @this_project.destroy
    if self.current_user.admin
      redirect_to "/project"
    end
    if self.current_user.moderator
      redirect_to "/moderator"
    end
  end

end
