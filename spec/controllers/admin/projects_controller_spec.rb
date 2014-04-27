require 'spec_helper'

describe Admin::ProjectsController do
  before { controller.stub(:current_user).and_return(:user) }
  
  let(:user) { Fabricate(:user) }
  let(:project) { Fabricate(:project) }
  
  describe '#index' do
    it 'should response with 200' do
      get :index
      response.should be_success
    end

    it 'should find projects' do
      get :index
      assigns[:projects].should == [project]
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
    let(:params) { {project: {production_url: 'http://test.com', description: 'd'}} }
    
    it 'should redirect to projects' do
      post :create, params
      response.should redirect_to(admin_projects_path)
    end

    it 'should create project' do
      expect {
       post :create, params
      }.to change(Project, :count).by(1)
    end

    it 'should show flash notice' do
      post :create, params
      flash[:notice].should == I18n.t('messages.project_created')
    end

    context 'not successfull' do
      before { Project.any_instance.stub(:save).and_return(false) }

      it 'should create project' do
        expect { post(:create, params) }.not_to change(Project, :count)
      end

      it 'should render new template' do
        post :create, params
        response.should render_template(:new)
      end
    end
  end

  describe '#edit' do
    it 'should response with 200' do
      get :edit, id: project.id
      response.should be_success
    end

    it 'should render new template' do
      get :edit, id: project.id
      response.should render_template(:edit)
    end
  end

  describe '#update' do
    it 'should redirect to projects' do
      put :update, id: project.id, project: {description: 'New description'}
      response.should redirect_to(admin_projects_path)
    end

    it 'should udpate project' do
      put :update, id: project.id, project: {description: 'New description'}
      project.reload.description.should == 'New description'
    end

    it 'should show flash notice' do
      put :update, id: project.id, project: {description: 'New description'}
      flash[:notice].should == I18n.t('messages.project_updated')
    end

    context 'not successfull' do
      before { Project.any_instance.stub(:save).and_return(false) }
      
      it 'should render new template' do
        put :update, id: project.id, project: {description: 'New description'}
        response.should render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    before { Project.stub(:find).and_return(project) }
    
    it 'should delete project' do
      expect {
        delete(:destroy, id: project.id)
      }.to change(Project, :count).by(-1)
    end

    it 'should redirect to projects' do
      delete :destroy, id: project.id
      response.should redirect_to(admin_projects_path)
    end

    it 'should show flash notice' do
      delete :destroy, id: project.id
      flash[:notice].should == I18n.t('messages.project_deleted')
    end
  end
end