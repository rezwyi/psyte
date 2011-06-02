require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'about action should render static file in /static/about-<current locale>.html' do
    get :about
    assert_template "/static/about-#{I18n.locale}.html"
  end
end
