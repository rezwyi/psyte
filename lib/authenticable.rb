module Authenticable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    unless current_user
      flash[:alert] = I18n.t('messages.forbidden')
      redirect_to(root_path)
    end
  end
end