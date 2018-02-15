Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get 'login', :to => 'sessions#new'
  post 'login', :to => 'sessions#create'
  delete 'logout', :to => 'sessions#destroy'

  get 'support/index', to: 'chatrooms#index'


  resources :chatrooms, param: :slug, only: [:show, :index, :new, :create, :destroy]
  resources :messages

  resource :dashboard, only: :show
  resource :cart, only: [:show, :create, :update, :destroy]
  resources :users , only: [:new, :create, :update]
  get 'account/edit', to: 'users#edit', as: 'edit_user'
  resources :orders, only: [:index, :create, :show, :update]
  resources :items, only: [:index, :show]
  resources :categories, only: :show, param: :category_slug
  resources :charges, only: [:new, :create]
  get 'thanks', to: 'charges#thanks', as: 'thanks'

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

  get 'auth/twitter', as: :twitter_login
  get 'auth/twitter/callback', to: 'twitter_accounts#new'
  resources :twitter_accounts, only: :create

  resources :stores, only: [:new, :create, :index]
  resources :stores, only: [:update, :show], path: '/', param: :slug do
    resources :tweets, only: [:new, :create]
  end

end
