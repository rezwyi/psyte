class Admin::PostsController < Admin::ApplicationController
  def index
    @resources = Post.managed
    respond_with @resources
  end

  private

  def create_params(namespace)
    params.require(namespace).permit(:title, :published_at, :body)
  end

  def update_params(namespace)
    create_params namespace
  end
end
