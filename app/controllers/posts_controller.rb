class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    respond_with @post
  end
end
