class PagesController < ApplicationController
  def home
    @posts = Post.recent
    @projects = Project.recent
    @about = Snippet.find_by_name(:about)
  end
end
