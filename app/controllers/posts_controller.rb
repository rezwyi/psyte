class PostsController < ApplicationController
  def index
    @posts = Post.published.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def feed
    @posts = Post.published
  end
end
