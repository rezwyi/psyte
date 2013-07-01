require 'spec_helper'

describe SessionsController do
  let(:user) { Fabricate(:user) }
  
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
    before { User.stub(:authenticate).and_return(user) }
    
    let(:params) do
      {:login => 'jryan', :password => '123456'}
    end

    it 'should redirect to root' do
      post :create, params
      response.should redirect_to(admin_posts_path)
    end

    it 'should show flash notice' do
      post :create, params
      flash[:notice].should == I18n.t('messages.welcome')
    end

    it 'should store user id to session' do
      post :create, params
      session[:user_id].should == user.id
    end
    
    context 'with invalid params' do
      before { User.stub(:authenticate).and_return(nil) }
      
      it 'should show flash alert' do
        post :create, params
        flash[:alert].should == I18n.t('messages.wrong_login_or_password')
      end

      it 'should render new template again' do
        post :create, params
        response.should render_template(:new)
      end

      it 'should not store user id to session' do
        post :create, params
        session[:user_id].should be_nil
      end
    end
  end

  describe '#destroy' do
    it 'should destroy session id' do
      session[:user_id] = user.id
      delete :destroy
      session[:user_id].should be_nil
    end
    
    it 'should redirect to root' do
      delete :destroy
      response.should redirect_to(root_path)
    end
  end
end