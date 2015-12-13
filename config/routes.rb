Rails.application.routes.draw do

  devise_for :users

  root to: "home#index"
  get "timeline" => "home#timeline"
  post "search" => "home#search"

  resources :users, only: [:show] do 
    resources :tweets, only: [:create, :update, :destroy] do
      member do
        post 'retweet'
        post 'unretweet'
      end
    end

    resources :likes, only: [:index, :create, :destroy]
    resources :followings, only: [:index, :create, :destroy]
  end
  match "users/:user_id/followers", to: 'followings#followers_index', via: :get, as: :user_followers
end
