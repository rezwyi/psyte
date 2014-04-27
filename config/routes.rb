Psyte::Application.routes.draw do
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  resources :sessions, only: :create
  resources :posts, only: :show
  
  namespace :admin do
    resources :posts, except: :show
    resources :projects, except: :show
  end

  root to: 'pages#home'
end