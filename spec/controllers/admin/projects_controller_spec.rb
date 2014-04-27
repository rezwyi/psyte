require 'spec_helper'

describe Admin::ProjectsController do
  let(:user) { Fabricate(:user) }
  let(:project) { Fabricate(:project) }
  
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
    let(:params) { {project: {production_url: 'http://test.com', description: 'd'}} }

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

      it 'should create project' do
        expect { post(:create, params) }.to change(Project, :count).by(1)
      end

      it 'should show flash notice' do
        post :create, params
        expect(flash[:notice]).to eql(I18n.t('messages.project_created'))
      end
      
      it 'should redirect to projects' do
        post :create, params
        response.should redirect_to(admin_projects_path)
      end

      context 'when not successfull' do
        before { Project.any_instance.stub(:save).and_return(false) }

        it 'should not create project' do
          expect { post(:create, params) }.not_to change(Project, :count)
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
      get :edit, id: project.id
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end
    
    it 'should redirect to root' do
      get :edit, id: project.id
      response.should redirect_to(root_path)
    end

    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }

      it 'should response with 200' do
        get :edit, id: project.id
        response.should be_success
      end
    end
  end

  describe '#update' do
    before { project }
    
    let(:params) { {id: project.id, project: {description: 'New description'}} }

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

      it 'should udpate project' do
        put :update, params
        expect { project.reload }.to change(project, :description).to('New description')
      end

      it 'should show flash notice' do
        put :update, params
        expect(flash[:notice]).to eql(I18n.t('messages.project_updated'))
      end

      it 'should redirect to projects' do
        put :update, params
        response.should redirect_to(admin_projects_path)
      end

      context 'when not successfull' do
        before { Project.any_instance.stub(:save).and_return(false) }

        it 'should not udpate project' do
          put :update, params
          expect { project.reload }.not_to change(project, :description)
        end

        it 'should show flash notice' do
          put :update, params
          expect(flash[:notice]).to be_nil
        end
      end
    end
  end

  describe '#destroy' do
    before { Project.stub(:find).and_return(project) }

    it 'should show flash alert' do
      delete :destroy, id: project.id
      expect(flash[:alert]).to eql(I18n.t('messages.forbidden'))
    end

    it 'should redirect to root' do
      delete :destroy, id: project.id
      response.should redirect_to(root_path)
    end

    context 'when user is logged in' do
      before { controller.stub(:current_user).and_return(:user) }

      it 'should delete project' do
        expect { delete(:destroy, id: project.id) }.to change(Project, :count).by(-1)
      end

      it 'should redirect to projects' do
        delete :destroy, id: project.id
        response.should redirect_to(admin_projects_path)
      end

      it 'should show flash notice' do
        delete :destroy, id: project.id
        expect(flash[:notice]).to eql(I18n.t('messages.project_deleted'))
      end

      context 'when not successfull' do
        before { Project.any_instance.stub(:destroy).and_return(false) }

        it 'should not delete project' do
          expect { delete(:destroy, id: project.id) }.not_to change(Project, :count)
        end

        it 'should not show flash notice' do
          delete :destroy, id: project.id
          expect(flash[:notice]).to be_nil
        end
      end
    end
  end
end