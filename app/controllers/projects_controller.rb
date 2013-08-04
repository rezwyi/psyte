class ProjectsController < ApplicationController
  def index
    @projects = Project.active
    respond_with @post
  end
end
