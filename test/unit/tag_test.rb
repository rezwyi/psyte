require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def setup
    @count = Tag.all.count
    @tag_1 = tags(:tag_1)
  end

  test 'should not be valid without name' do
    @tag_1.name = nil
    assert !@tag_1.valid?
  end

  test 'should create three new tags' do
    Tag.with_names(%w[four five six]).map(&:save)
    assert_in_delta @count + 3, Tag.all.count, 3
  end

end
