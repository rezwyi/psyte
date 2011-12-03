require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'should display correct title' do
    get :home
    assert_select 'title', title(t(:welcome))
    login_as :user
    get :manage, { :i => 'posts' }
    assert_select 'title', title(t('head.title.manage_posts'))
    get :manage, { :i => 'projects' }
    assert_select 'title', title(t('head.title.manage_projects'))
  end
end
