class Admin::ApplicationController < ActionController::Base
  include Shared::Authenticable
  layout 'admin'
  before_action :login_required
  respond_to :html
end
