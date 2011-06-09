require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:user)
  end

  def teardown
    @user = nil
  end

  test 'action new should render new template' do
    get :new
    assert_template :new
  end

  test 'if user and password is valid create action should create new session' do
    post :create, :login => 'user', :password => '123'
    assert_equal session[:user_id], @user.id
    assert_redirected_to posts_path
  end

  test 'if user and password is not valid  create action should render new template' do
    post :create, :login => 'user', :password => '1234'
    assert_not_equal session[:user_id], @user.id
    assert_template :new
    post :create, :login => 'user1', :password => '1234'
    assert_not_equal session[:user_id], @user.id
    assert_template :new
    post :create, :login => 'user2', :password => '123'
    assert_not_equal session[:user_id], @user.id
    assert_template :new
  end
  
  test 'destroy action should destroy session' do
    delete :destroy
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end

  test 'new view should set title to "login - title"' do
    get :new
    assert_select 'title', [t('layouts.application.login'), t(:title)].join(' - ')
  end

end
