ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def t(name)
    I18n.t(name)
  end

  def login_as(name)
    user = User.find_by_name(name)
    session[:user_id] = user.id
  end 
end
