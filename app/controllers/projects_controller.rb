class ProjectsController < ApplicationController
  def index
    @projects = Project.active
  end
end
