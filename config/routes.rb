Rails.application.routes.draw do

  devise_for :users

  root to: "home#index"
  get "timeline" => "home#timeline"
  post "search" => "home#search"

  resources :users, only: [:show] do 
    resources :tweets, only: [:create, :update, :destroy] do
      member do
        post 'retweet'
      end
    end

    resources :likes, only: [:create, :destroy]

    member do
      post :follow
      post :unfollow
    end
  end
end
