require 'spec_helper'

describe User do
  it { should validate_uniqueness_of(:login) }

  describe '#authenticate' do
    let(:user) { Fabricate(:user) }

    it 'should return nil' do
      User.authenticate('test', '123').should be_nil
    end

    it 'should return nil' do
      User.stub(:find_by_login).and_return(user)
      User.authenticate('jryan', '123').should be_nil
    end

    it 'should return user' do
      User.stub(:find_by_login).and_return(user)
      User.authenticate('jryan', '123456').should == user
    end
  end
end