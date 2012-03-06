class SessionsController < ApplicationController
  respond_to :html, :js

  def new
  end

  def create
    #prevent session fixation
    reset_session

    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id

      respond_with do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
