require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post_1 = posts(:post_1)
    @post_2 = posts(:post_2)
    @post_3 = posts(:post_3)
  end

  def teardown
    @post_1 = nil
    @post_2 = nil
    @post_3 = nil
  end

  test 'should not be valid without title' do
    @post_1.title = nil
    assert !@post_1.valid? 
  end
  
  test 'should not be valid without published_at' do
    @post_1.published_at = nil
    assert !@post_1.valid?      
  end
  
  test 'should not save without markdown' do
    @post_1.markdown = nil
    assert !@post_1.valid?
  end
  
  test 'preface and content should not be empty if the markdown contains the delimiter' do
    @post_1.save
    assert @post_1.preface && @post_1.content
  end
  
  test 'preface should be empty but the content is not if markdown not contain the delimiter' do
    @post_2.save
    assert !@post_2.preface && @post_2.content
  end

  test 'published scope should return only the published posts' do
    only_published = true
    Post.published.each do |post|
      only_published &&= (post.published_at <= Time.now.utc)
    end
    assert only_published
  end

end
