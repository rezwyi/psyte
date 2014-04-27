class Admin::ApplicationController < ActionController::Base
  include Authenticable
  protect_from_forgery
  layout 'admin'
  before_action :login_required
end
