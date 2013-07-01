Psyte::Application.routes.draw do
  get '/login', :to => 'sessions#new'
  delete '/logout', :to => 'sessions#destroy'

  resources :sessions, :only => :create
  resources :projects, :except => :index
  resources :posts, :except => :index

  root :to => 'pages#home'
end
