class Admin::SnippetsController < Admin::ApplicationController
  def index
    @snippets = Snippet.managed.page(params[:page]).per(4)
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.create(params[:snippet])
    if @snippet.save
      redirect_to admin_snippets_path
    else
      render 'new'
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
  end

  def update
    @snippet = Snippet.find(params[:id])
    if @snippet.update_attributes(params[:snippet])
      redirect_to admin_snippets_path
    else
      render 'edit'
    end
  end

  def destroy
    @snippet = Snippet.find(params[:id]).destroy
    redirect_to admin_snippets_path
  end
end
