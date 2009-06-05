class ProjectController < ApplicationController
  
  def index
    @project = Project.find(:all)
  end
  
  def new
    @project = Project.find(:all)
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:projects])
    @project.save
    #redirect_to  "/comment/new"
    render :text => "Project Created!"
  end
  
  def drop
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to "/project"
  end

end
