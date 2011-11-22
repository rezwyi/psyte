require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project_1 = projects(:project_1)
  end

  def teardown
    @project_1 = nil
  end

  test 'should not be valid without title' do
    @project_1.title = nil
    assert !@project_1.valid? 
  end
  
  test 'should not be valid without description' do
    @project_1.description = nil
    assert !@project_1.valid?      
  end
  
  test 'should not be valid without image_url' do
    @project_1.image_url = nil
    assert !@project_1.valid?
  end

  test 'recent scope should return sorted projects' do
    assert_equal Project.recent.length, 5
  end
end
