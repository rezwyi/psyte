require 'spec_helper'

describe SessionsController do
  let(:user) { Fabricate(:user) }
  
  describe '#new' do
    it 'should response with 200' do
      get :new
      response.should be_success
    end
  end

  describe '#create' do
    before { user }
    
    let(:params) { {login: 'jryan', password: '123456'} }

    it 'should show flash notice' do
      post :create, params
      expect(flash[:notice]).to eql(I18n.t('messages.welcome'))
    end

    it 'should store user id to session' do
      post :create, params
      expect(session[:user_id]).to eql(user.id)
    end

    it 'should redirect to admin root' do
      post :create, params
      response.should redirect_to(admin_posts_path)
    end
    
    context 'with invalid params' do
      before { User.stub(:authenticate).and_return(false) }

      it 'should not store user id to session' do
        post :create, params
        expect(session[:user_id]).to be_nil
      end

      it 'should show flash alert' do
        post :create, params
        expect(flash[:alert]).to eql(I18n.t('messages.wrong_login_or_password'))
      end
    end
  end

  describe '#destroy' do
    before { session[:user_id] = user.id }
    
    it 'should destroy session id' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
    
    it 'should redirect to root' do
      delete :destroy
      response.should redirect_to(root_path)
    end
  end
end