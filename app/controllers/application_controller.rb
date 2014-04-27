class ApplicationController < ActionController::Base
  include Shared::Authenticable
  respond_to :html
end