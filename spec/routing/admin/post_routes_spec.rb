require 'spec_helper'

describe 'Admin post routes' do
  it 'should routes to #index' do
    get('/admin/posts').should route_to('admin/posts#index')
  end
  
  it 'should routes to #new' do
    get('/admin/posts/new').should route_to('admin/posts#new')
  end

  it 'should routes to #create' do
    post('/admin/posts').should route_to('admin/posts#create')
  end

  it 'should routes to #edit' do
    get('/admin/posts/1/edit').should route_to('admin/posts#edit', :id => '1')
  end

  it 'should routes to #update' do
    put('/admin/posts/1').should route_to('admin/posts#update', :id => '1')
  end

  it 'should routes to #destroy' do
    delete('/admin/posts/1').should route_to('admin/posts#destroy', :id => '1')
  end
end