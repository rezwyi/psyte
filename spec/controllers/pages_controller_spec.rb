require 'spec_helper'

describe PagesController do
	let(:user) { Fabricate(:user) }
  
  describe '#home' do
    it 'should response with 200' do
      get :home
      response.should be_success
    end

    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }

      it 'should response with 200' do
        get :home
        response.should be_success
      end
    end
  end
end