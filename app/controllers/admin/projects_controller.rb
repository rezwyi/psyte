class Admin::ProjectsController < Admin::ApplicationController
  def index
    @projects = Project.managed
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = I18n.t('messages.project_created')
      redirect_to admin_projects_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = I18n.t('messages.project_updated')
      redirect_to admin_projects_path
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:notice] = I18n.t('messages.project_deleted')
    redirect_to admin_projects_path
  end
end
