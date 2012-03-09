class SearchesController < ApplicationController
  def index
    unless params[:query].blank?
      @posts = Post.published.where("markdown like ?", params[:query].sub(/(.*)/, '%\1%'))
    else
      redirect_to posts_path
    end
  end
end
