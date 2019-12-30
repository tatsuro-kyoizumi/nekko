Rails.application.routes.draw do
  get 'messages/create'
  get '/home' => 'home#top'
  get '/chat' => 'home#index'
  root 'users#index'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :search_posts
      get :search_users
      get :chat
    end
  end

  resources :posts do
    resource :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end
end
