class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.published
  end

  def feed
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.published
  end

end
