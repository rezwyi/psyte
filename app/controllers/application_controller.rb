class ApplicationController < ActionController::Base
	include Authenticable
  protect_from_forgery
  respond_to :html, :js
end
