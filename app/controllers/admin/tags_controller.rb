class Admin::TagsController < Admin::ApplicationController
  def index
    @tags = Tag.managed.page(params[:page]).per(4)
  end

  def show
    @tags = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(params[:tag])
    if @tag.save
      redirect_to admin_tags_path
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(params[:tag])
      redirect_to admin_tags_path
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id]).destroy
      redirect_to admin_tags_path
  end
end
