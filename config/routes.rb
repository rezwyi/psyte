Psyte::Application.routes.draw do
  match 'login', :to => 'sessions#new'
  match 'logout', :to => 'sessions#destroy'

  resources :sessions, :only => [:new, :create, :destroy]
  resources :projects, :except => :index
  resources :posts, :except => :index

  root :to => 'pages#home'
end
