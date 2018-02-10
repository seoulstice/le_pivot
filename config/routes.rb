Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/twitter/callback', to: 'twitter#update'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'auth/twitter', as: :twitter_login
  get 'twitter/new', to: 'twitter#new', as: 'new_twitter'
  post 'twitter/new', to: 'twitter#create'

  get 'login', :to => 'sessions#new'
  post 'login', :to => 'sessions#create'
  delete 'logout', :to => 'sessions#destroy'

  get 'support/index', to: 'chatrooms#index'
  get 'support', to: 'chatrooms#show'
  get 'support/new', to: 'chatrooms#new', as: 'new_chatroom'
  post 'support/new', to: 'chatrooms#new'

  resource :dashboard, only: :show
  resource :cart, only: [:show, :create, :update, :destroy]
  resources :users , only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show, :update]
  resources :items, only: :show
  resources :categories, only: :show, param: :category_slug

  scope path: :settings do
    resource :developer, only: [:show, :create, :update]
  end

  namespace :admin do
    resource :dashboard, only: :show
    resource :analytics, only: :show
    resources :items, only: [:index, :edit, :new, :create, :update]
  end

  namespace :api do
    namespace :v1 do
      resource :search, only: :show
    end
  end

  resources :stores, only: [:new, :create, :index]
  resources :stores, only: [:update, :show], path: '/', param: :slug

end
