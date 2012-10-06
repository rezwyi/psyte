Psyte::Application.routes.draw do
  get 'searches/index'

  match 'login', :to => 'sessions#new'
  match 'logout', :to => 'sessions#destroy'

  resources :sessions
  resources :posts, :only => [ :index, :show ] do
    get 'feed', :on => :collection, :format => :rss
  end
  resources :tags, :only => [ :index, :show ] do
    get 'feed', :on => :member, :format => :rss
  end
  resources :projects, :only => [ :index, :show ] do
    get 'feed', :on => :collection, :format => :rss
  end

  namespace :admin do
    resources :posts, :except => :show
    resources :projects, :except => :show
    resources :tags, :except => :show
    resources :snippets, :except => :show
  end

  root :to => 'pages#home'
end
