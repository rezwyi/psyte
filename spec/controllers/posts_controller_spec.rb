require 'spec_helper'

describe PostsController do
  let(:user) { Fabricate(:user) }
  let(:blog_post) { Fabricate(:post) }
  
  describe '#show' do
    context 'when accessible by id' do
      it 'should response with 200' do
        get :show, id: blog_post.id
        response.should be_success
      end

      context 'when user is logged in' do
        before { controller.stub(:current_user).and_return(:user) }

        it 'should response with 200' do
          get :show, id: blog_post.id
          response.should be_success
        end
      end
    end

    context 'when accessible by to_param' do
      it 'should response with 200' do
        get :show, id: blog_post.to_param
        response.should be_success
      end

      context 'when user is logged in' do
        before { controller.stub(:current_user).and_return(:user) }

        it 'should response with 200' do
          get :show, id: blog_post.to_param
          response.should be_success
        end
      end
    end
  end
end