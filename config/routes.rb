Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/twitter/callback', to: 'twitter#update'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'twitter/new', to: 'twitter#new', as: 'new_twitter'
  post 'twitter/new', to: 'twitter#create'

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

<<<<<<< HEAD
  resource :dashboard, only: :show
  resource :cart, only: [:show, :create, :update, :destroy]
=======
  get '/auth/twitter', as: :twitter_login

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]
  end


>>>>>>> Added Twitter Feature
  resources :users , only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :new, :show, :update]
  resources :items, only: [:index, :show]
  resources :categories, only: :show, param: :category_slug

  scope path: :settings do
    resource :developer, only: [:show, :create, :update]
  end

  namespace :admin do
    resource :dashboard, only: :show
    resource :analytics, only: :show
    resources :items, only: [:index, :edit, :new, :create, :update]
  end

end
