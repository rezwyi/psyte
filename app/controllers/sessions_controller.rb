class SessionsController < ApplicationController
  layout 'login'

  def new
    respond_with({})
  end

  def create
    reset_session
    if (user = User.authenticate(params[:login], params[:password]))
      session[:user_id] = user.id
      flash[:notice] = I18n.t('messages.welcome')
    else
      flash[:alert] = I18n.t('messages.wrong_login_or_password')
    end
    respond_with({}, location: admin_posts_path)
  end

  def destroy
    session[:user_id] = nil
    respond_with({}, location: root_path)
  end
end
