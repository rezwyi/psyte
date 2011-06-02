class SearchesController < ApplicationController
  def index
    unless params[:query].blank?
      @posts = Post.published.find(:all, :conditions => ["markdown like ?", params[:query].sub(/(.*)/, '%\1%')]).paginate(:page => params[:page])
    else
      redirect_to posts_path
    end
  end
end
