require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  def setup
    request.env['HTTP_REFERER'] = '/'

    @project_1 = projects(:project_1)
  end

  def teardown
    @project_1 = nil
  end

  test 'index action should render index template' do
    get :index
    assert_not_nil assigns(:projects)
    assert_template :index
  end

  test 'feed action should render feed template for rss with xml' do
    get :feed, :format => :rss
    assert_not_nil assigns(:projects)
    assert_template :feed
    assert_equal 'application/rss+xml; charset=utf-8', response.headers['Content-Type'] 
  end

  test 'show action should show project' do
    get :show, :id => @project_1.id
    assert_not_nil assigns(:project)
    assert_template :show
  end

  test 'if user not logged in new action redirects to root' do
    get :new
    assert_redirected_to root_path
  end

  test 'if user not logged in create action redirects to root' do
    post :create, :project => { :title => 'project_99',
                                :image_url => 'http://images.com/image99',
                                :description => 'description'}
    assert_redirected_to root_path
  end

  test 'if user not logged in edit action redirects to root' do
    get :edit, :id => @project_1.id
    assert_redirected_to root_path
  end

  test 'if user not logged in update action redirects to root' do
    @project_1.description = 'description'.reverse
    post :update, :id => @project_1.id
    assert_redirected_to root_path
  end

  test 'if user not logged in delete action redirects to root' do
    delete :destroy, :id => @project_1.id
    assert_redirected_to root_path
  end

  test 'should display correct title' do
    get :index
    assert_select 'title', title(t('common.projects'))
    get :show, :id => @project_1.id
    assert_select 'title', title("'#{@project_1.title}'")
    get :feed, :format => :rss
    assert_select 'title', t(:title)
    login_as :user
    get :new
    assert_select 'title', title(t('head.title.new_project'))
    get :edit, :id => @project_1.id
    assert_select 'title', title("#{t('head.title.edit')} '#{@project_1.title}'")
  end
end
