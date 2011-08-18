Psyte::Application.routes.draw do
  get 'pages/about'
  get 'searches/index'

  match 'login', :to => 'sessions#new'
  match 'logout', :to => 'sessions#destroy'

  resources :sessions
  resources :posts do
    get 'manage', :on => :collection
    get 'feed', :on => :collection, :format => :rss
  end
  resources :tags, :only => [:show] do
    get 'feed', :on => :member, :format => :rss
  end

  root :to => 'posts#index'

end
