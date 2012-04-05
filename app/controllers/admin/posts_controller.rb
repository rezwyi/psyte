class Admin::PostsController < Admin::ApplicationController
  def index
    @posts = Post.managed.page(params[:page]).per(4)
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    @post = Post.create(params[:post])
    if @post.save
      redirect_to admin_posts_path
    else
      @tags = Tag.all
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to admin_posts_path
    else
      @tags = Tag.all
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
      redirect_to admin_posts_path
  end
end
