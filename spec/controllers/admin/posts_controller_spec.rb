require 'spec_helper'

describe Admin::PostsController do
  let(:user) { Fabricate(:user) }
  let(:blog_post) { Fabricate(:post) }
  
  describe '#index' do
    it 'should show flash alert' do
      get :index
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end
    
    it 'should redirect to root' do
      get :index
      response.should redirect_to(root_path)
    end

    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }

      it 'should response with 200' do
        get :index
        response.should be_success
      end
    end
  end

  describe '#new' do
    it 'should show flash alert' do
      get :new
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end
    
    it 'should redirect to root' do
      get :new
      response.should redirect_to(root_path)
    end

    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }

      it 'should response with 200' do
        get :new
        response.should be_success
      end
    end
  end

  describe '#create' do
    let(:params) { {post: {title: 't', published_at: '01/01/2000', body: 'b'}} }

    it 'should show flash alert' do
      post :create, params
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end

    it 'should redirect to root' do
      post :create, params
      response.should redirect_to(root_path)
    end

    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }

      it 'should redirect to posts' do
        post :create, params
        response.should redirect_to(admin_posts_path)
      end

      it 'should create post' do
        expect { post(:create, params) }.to change(Post, :count).by(1)
      end

      it 'should show flash notice' do
        post :create, params
        expect(flash[:notice]).to eql(I18n.t('messages.post_created'))
      end

      context 'when not successfull' do
        before { Post.any_instance.stub(:save).and_return(false) }

        it 'should not create post' do
          expect { post(:create, params) }.not_to change(Post, :count)
        end

        it 'should not show flash notice' do
          post :create, params
          expect(flash[:notice]).to be_nil
        end
      end
    end
  end

  describe '#edit' do
    it 'should show flash alert' do
      get :edit, id: blog_post.id
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end
    
    it 'should redirect to root' do
      get :edit, id: blog_post.id
      response.should redirect_to(root_path)
    end

    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }

      it 'should response with 200' do
        get :edit, id: blog_post.id
        response.should be_success
      end
    end
  end

  describe '#update' do
    before { blog_post }

    let(:params) { {id: blog_post.id, post: {title: 'New title'}} }

    it 'should show flash alert' do
      put :update, params
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end
    
    it 'should redirect to root' do
      put :update, params
      response.should redirect_to(root_path)
    end
    
    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }  

      it 'should udpate post' do
        put :update, params
        expect { blog_post.reload }.to change(blog_post, :title).to('New title')
      end

      it 'should show flash notice' do
        put :update, params
        expect(flash[:notice]).to eql(I18n.t('messages.post_updated'))
      end

      it 'should redirect to posts' do
        put :update, params
        response.should redirect_to(admin_posts_path)
      end

      context 'not successfull' do
        before { Post.any_instance.stub(:save).and_return(false) }
        
        it 'should not update post' do
          put :update, params
          expect { blog_post.reload }.not_to change(blog_post, :title).to('New title')
        end

        it 'should not show flash notice' do
          put :update, params
          expect(flash[:notice]).to be_nil
        end
      end
    end
  end

  describe '#destroy' do
    before { Post.stub(:find).and_return(blog_post) }

    it 'should show flash alert' do
      delete :destroy, id: blog_post.id
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end

    it 'should redirect to root' do
      delete :destroy, id: blog_post.id
      response.should redirect_to(root_path)
    end
    
    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }
      
      it 'should delete post' do
        expect { delete(:destroy, id: blog_post.id) }.to change(Post, :count).by(-1)
      end

      it 'should show flash notice' do
        delete :destroy, id: blog_post.id
        expect(flash[:notice]).to eql(I18n.t('messages.post_deleted'))
      end

      it 'should redirect to posts' do
        delete :destroy, id: blog_post.id
        response.should redirect_to(admin_posts_path)
      end

      context 'when not successfull' do
        before { Post.any_instance.stub(:destroy).and_return(false) }

        it 'should not delete post' do
          expect { delete(:destroy, id: blog_post.id) }.not_to change(Post, :count)
        end

        it 'should not show flash notice' do
          delete :destroy, id: blog_post.id
          expect(flash[:notice]).to be_nil
        end
      end
    end
  end
end