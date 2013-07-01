require 'spec_helper'

describe 'Session routes' do
  it 'should routes to #new' do
    get('/login').should route_to('sessions#new')
  end

  it 'should routes to #destroy' do
    delete('/logout').should route_to('sessions#destroy')
  end

  it 'should routes to #create' do
    post('/sessions').should route_to('sessions#create')
  end
end