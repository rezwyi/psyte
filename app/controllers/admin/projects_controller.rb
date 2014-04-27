class Admin::ProjectsController < Admin::ApplicationController
  def index
    @resources = Project.managed
    respond_with @resources
  end

  private

  def create_params(namespace)
    params.require(namespace).permit(:production_url, :description)
  end

  def update_params(namespace)
    create_params namespace
  end
end
