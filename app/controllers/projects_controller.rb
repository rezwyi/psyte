class ProjectsController < ApplicationController
  def index
    @projects = Project.active.page(params[:page])
  end
  
  def show
    @project = Project.find(params[:id])
  end

  def feed
    @projects = Project.all
  end
end
