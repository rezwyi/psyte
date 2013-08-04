class PagesController < ApplicationController
  def home
    @posts = Post.recent
    @projects = Project.recent
    respond_with({})
  end
end
