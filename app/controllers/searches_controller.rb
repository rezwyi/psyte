class SearchesController < ApplicationController
  def index
    unless params[:q].blank?
      @posts = Post.published(:conditions => ["markdown like ?", params[:q].sub(/(.*)/, '%\1%')]).page(params[:page])
    else
      redirect_to posts_path
    end
  end
end
