class PagesController < ApplicationController
  before_filter :login_required, :only => [ :manage ]

  def home
    @posts = Post.recent
    @projects = Project.recent
  end
  
  def manage
    @items = params[:i] == 'projects' ? Project.managed : Post.managed
  end
end
