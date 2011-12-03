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
    assert_select '.tag-posts',
                  "#{t('tags.show.tag_posts')} \"#{@tag_1.name}\" (#{t('common.count')} #{assigns(:posts).count.to_s})"
  end

  test 'feed action should reder feed template for rss with xml' do
    get :feed, :id => @tag_1.id, :format => :rss
    assert !assigns(:tag).nil? && !assigns(:posts).nil?
    assert_equal 'application/rss+xml; charset=utf-8', response.headers['Content-Type']
    assert_template :feed
  end

  test 'should display correct title' do
    get :show, :id => @tag_1.id
    assert_select 'title', title("#{t('head.title.tag')} '#{@tag_1.name}'")
    get :feed, :id => @tag_1.id, :format => :rss
    assert_select 'title', t(:title)
  end
end
