require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test 'index action with no params should redirects to posts' do
    get :index
    assert_redirected_to posts_path
  end

  test 'index action should find some posts' do
    get :index, { :query => 'content' }
    assert_not_nil assigns(:posts)
    assert_template :index
    assert_select '.search-posts',
                  "#{t('searches.index.search_posts')} \"content\" (#{t('common.count')} #{assigns(:posts).count.to_s})"
  end

  test 'should display correct title' do
    get :index, { :query => 'content' }
    assert_select 'title', title(t('common.search'))
  end
end
