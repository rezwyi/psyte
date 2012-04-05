class Admin::ProjectsController < Admin::ApplicationController
  def index
    @projects = Project.managed.page(params[:page]).per(4)
  end
  
  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(params[:project])
    if @project.save
      redirect_to admin_projects_path
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to admin_projects_path
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id]).destroy
      redirect_to admin_projects_path
  end
end
