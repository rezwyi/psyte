class SessionsController < ApplicationController
  def new
  end

  def create
    #prevent session fixation
    reset_session
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
