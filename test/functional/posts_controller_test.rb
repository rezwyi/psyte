require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    request.env['HTTP_REFERER'] = '/'

    @post_1 = posts(:post_1)
    @per_page = 7
  end

  def teardown
    @post_1 = nil
  end

  test 'index action should render index template' do
    get :index
    assert_not_nil assigns(:posts)
    assert_template :index
  end

  test 'feed action should render feed template for rss with xml' do
    get :feed, :format => :rss
    assert_not_nil assigns(:posts)
    assert_template :feed
    assert_equal 'application/rss+xml; charset=utf-8', response.headers['Content-Type'] 
  end

  test 'show action should show post' do
    get :show, :id => @post_1.id
    assert_not_nil assigns(:post)
    assert_template :show
  end

  test 'if user not logged in new action redirects to root' do
    get :new
    assert_redirected_to root_path
  end

  test 'if user not logged in create action redirects to root' do
    post :create, :post => { :title => 'post_4', :published_at => 3.days.ago, :markdown => 'content'}
    assert_redirected_to root_path
  end

  test 'if user not logged in edit action redirects to root' do
    get :edit, :id => @post_1.id
    assert_redirected_to root_path
  end

  test 'if user not logged in update action redirects to root' do
    @post_1.markdown = 'content'.reverse
    post :update, :id => @post_1.id
    assert_redirected_to root_path
  end

  test 'if user not logged in delete action redirects to root' do
    delete :destroy, :id => @post_1.id
    assert_redirected_to root_path
  end

  test 'if user logged in new action should get new form' do
    login_as :user
    get :new
    assert_template :new
  end

  test 'if user logged in and post is valid create action should create post' do
    login_as :user
    assert_difference 'Post.count' do
      post :create, :post => { :title => 'post_4', :published_at => 3.days.ago, :markdown => 'content' }
    end
    assert_redirected_to post_path(assigns(:post))
  end

  test 'if user logged in and post is not valid create action should render new template' do
    login_as :user
    assert_no_difference 'Post.count' do
      post :create, :post => { :title => nil, :published_at => 3.days.ago, :markdown => 'content' }
    end
    assert_not_nil assigns(:post)
    assert_not_nil assigns(:tags)
    assert_template :new
  end

  test 'if user logged in edit action should get edit form' do
    login_as :user
    get :edit, :id => @post_1.id
    assert_not_nil assigns(:post)
    assert_template :edit
  end

  test 'if user logged in and post is valid udpate action should update post' do
    login_as :user
    put :update, :id => @post_1.id, :post => { :markdown => 'content'.reverse }
    assert_redirected_to post_path(assigns(:post))
  end

  test 'if user logged in and post is not valid udpate action should render edit template' do
    login_as :user
    put :update, :id => @post_1.id, :post => { :markdown => nil }
    assert_template :edit
  end

  test 'if user logged in destroy action should delete post' do
    login_as :user
    assert_difference 'Post.count', -1 do
      delete :destroy, :id => @post_1.id
    end
    assert_redirected_to root_path
  end

  test 'index view should show only :per_page posts' do
    get :index
    assert_select '#content div.post', @per_page
  end

  test 'post with preface should view "read-more" link' do
    get :index
    post = Post.find_by_title('fourth-post')
    assert_select "#content div#post-#{post.id}" do
      assert_select 'div.read-more', t('posts.post.read_more')
    end
  end

  test 'if posts count more than :per_page, index view should show pagination' do
    get :index
    assert_select 'div#pagination' do 
      assert_select 'ul li a', '1'
      assert_select 'ul li a', '2'
      # ... and more
    end
  end

end
