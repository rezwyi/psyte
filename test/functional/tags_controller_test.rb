require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  def setup
    @tag_1 = tags(:tag_1)
  end

  def teardown
    @tag_1 = nil
  end

  test 'show action should render show template with all posts with that tag' do
    get :show, :id => @tag_1.id
    assert !assigns(:tag).nil? && !assigns(:posts).nil?
    assert_template :show
  end

  test 'feed action should reder feed template for rss with xml' do
    get :feed, :id => @tag_1.id, :format => :rss
    assert !assigns(:tag).nil? && !assigns(:posts).nil?
    assert_equal 'application/rss+xml; charset=utf-8', response.headers['Content-Type']
    assert_template :feed
  end

  test 'show view should set title to "title - tag name"' do
    get :show, :id => @tag_1.id
    assert_select 'title', [@tag_1.name, t(:title)].join(' - ')
  end

end
