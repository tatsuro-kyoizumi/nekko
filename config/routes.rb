Rails.application.routes.draw do
  get '/home' => 'home#top'
  root :to => 'users#index'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :search_posts
      get :search_users
    end
  end

  resources :posts do
    resource :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
end
