class ProjectController < ApplicationController
  
  def index
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
  end
  
  def update
    @this_project = Project.find(params[:id])
    @this_project.update_attributes(params[:project])
    redirect_to "/project"
  end
  
  def drop
    @this_project = Project.find(params[:id])
    @this_project.destroy
    redirect_to "/project"
  end

end
