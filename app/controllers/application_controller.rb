class ApplicationController < ActionController::Base
  include Controllers::Authenticable
  respond_to :html, :js
end