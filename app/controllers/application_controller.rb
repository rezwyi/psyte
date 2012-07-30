class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  before_filter :last_tweet

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def last_tweet
    options = {:screen_name => 'rezwyi', :count => '1', :include_rts => 'false'}
    data = TwitterForRails::Api::Statuses.user_timeline(options)
    @last_tweet = JSON.parse(data)[0]
  end
end
