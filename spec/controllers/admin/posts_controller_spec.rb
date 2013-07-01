require 'spec_helper'

describe Admin::PostsController do
  before { controller.stub(:current_user).and_return(:user) }
  
  let(:user) { Fabricate(:user) }
  let(:blog_post) { Fabricate(:post) }
  
  describe '#index' do
    it 'should response with 200' do
      get :index
      response.should be_success
    end

    it 'should find posts' do
      get :index
      assigns[:posts].should == [blog_post]
    end
  end

  describe '#new' do
    it 'should response with 200' do
      get :new
      response.should be_success
    end

    it 'should render new template' do
      get :new
      response.should render_template(:new)
    end
  end

  describe '#create' do
    let(:params) do
      {:post => {:title => 't', :published_at => '01/01/2000', :body => 'b'}}
    end
    
    it 'should redirect to posts' do
      post :create, params
      response.should redirect_to(admin_posts_path)
    end

    it 'should create post' do
      expect {
       post :create, params
      }.to change(Post, :count).by(1)
    end

    it 'should redirect to posts' do
      post :create, params
      response.should redirect_to(admin_posts_path)
    end

    context 'not successfull' do
    end
  end

  describe '#edit' do
    it 'should response with 200' do
      get :edit, :id => blog_post.id
      response.should be_success
    end

    it 'should render new template' do
      get :edit, :id => blog_post.id
      response.should render_template(:edit)
    end
  end

  describe '#update' do
    it 'should redirect to posts' do
      put :update, :id => blog_post.id, :post => {:title => 'New title'}
      response.should redirect_to(admin_posts_path)
    end

    it 'should udpate post' do
      put :update, :id => blog_post.id, :post => {:title => 'New title'}
      blog_post.reload.title.should == 'New title'
    end

    context 'not successfull' do
      before { Post.any_instance.stub(:save).and_return(false) }
      
      it 'should render new template' do
        put :update, :id => blog_post.id, :post => {:title => 'New title'}
        response.should render_template(:edit)
      end
      
      it 'should not update post' do
        put :update, :id => blog_post.id, :post => {:title => 'New title'}
        blog_post.reload.body.should_not be_empty
      end
    end
  end

  describe '#destroy' do
    before { Post.stub(:find).and_return(blog_post) }
    
    it 'should delete post' do
      expect {
        delete :destroy, :id => blog_post.id
      }.to change(Post, :count).by(-1)
    end

    it 'should redirect to posts' do
      delete :destroy, :id => blog_post.id
      response.should redirect_to(admin_posts_path)
    end
  end
end