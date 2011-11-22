class PostsController < ApplicationController
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]

  def index
    @posts = Post.published.paginate(:page => params[:page], :per_page => Post.per_page)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
    @tags = Tag.all
  end

  def create
    @post = current_user.posts.create(params[:post])
    if @post.save
      redirect_to @post
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
      redirect_to @post
    else
      @tags = Tag.all
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to :back
  end

  def feed
    @posts = Post.published
  end
end
