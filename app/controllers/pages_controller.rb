class PagesController < ApplicationController
  def home
    @posts = Post.recent
    @projects = Project.recent
  end
end
