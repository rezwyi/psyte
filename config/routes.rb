Psyte::Application.routes.draw do
  get 'searches/index'

  match 'login', :to => 'sessions#new'
  match 'logout', :to => 'sessions#destroy'
  match 'manage', :to => 'pages#manage'

  resources :sessions
  resources :posts do
    get 'feed', :on => :collection, :format => :rss
  end
  resources :tags, :only => [ :show ] do
    get 'feed', :on => :member, :format => :rss
  end
  resources :projects do
    get 'feed', :on => :collection, :format => :rss
  end

  root :to => 'pages#home'
end
