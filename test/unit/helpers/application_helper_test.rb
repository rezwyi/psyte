require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  test 'should return correct title' do
    assert title('Title') ==  'Title - Rezvanov.info'
  end

  test 'should return correct copyright years' do
    assert copyright_years(2011, 2011) ==  '2011'
    assert copyright_years(2011, 2015) ==  '2011-2015'
  end
end
