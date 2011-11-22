class ProjectsController < ApplicationController
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]

  def index
    @projects = Project.all
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
      redirect_to projects_path
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
      redirect_to projects_path
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id]).destroy
    redirect_to :back
  end

  def feed
    @projects = Project.all
  end
end
