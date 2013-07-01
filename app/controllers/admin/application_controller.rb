class Admin::ApplicationController < ActionController::Base
  include Authenticable
  protect_from_forgery
  before_filter :login_required
  layout 'admin'
end
