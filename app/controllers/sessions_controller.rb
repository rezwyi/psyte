class SessionsController < ApplicationController
  respond_to :html
  respond_to :js, :only => :new

  layout 'login'

  def new
    respond_with({})
  end

  def create
    reset_session
    if (user = User.authenticate(params[:login], params[:password]))
      session[:user_id] = user.id
      flash[:notice] = I18n.t('messages.welcome')
      respond_with({}, :location => admin_posts_path)
    else
      flash[:alert] = I18n.t('messages.wrong_login_or_password')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
