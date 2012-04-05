class Admin::ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_required

  helper_method :current_user
  layout 'admin/layouts/application'

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    unless current_user
      redirect_to root_path
    end
  end
end
