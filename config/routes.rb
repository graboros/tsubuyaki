Rails.application.routes.draw do

  devise_for :users

  root to: "home#index"
  post :search, to: "home#search"

  resources :users, only: [:show] do
    resources :tweets, only: [:create, :destroy] do
      member do
        post :retweet, :unretweet
      end
      resources :likes, only: [:create, :destroy]
    end

    resources :likes, only: [:index]
    resources :followings, only: [:index, :create, :destroy]
    resource :profile, only: [:edit, :update]
  end

  resources :dms, only: [:index, :show, :new, :create] do
    resources :dm_messages, only: [:create]
    collection do
      post :search_user
    end
  end

  # ヘルパーの名前をfollowingsと同じようにして、actionをfollowingsと同じコントローラに入れるためにはmatchを使うしかなかった
  match "users/:user_id/followers", to: 'followings#followers_index', via: :get, as: :user_followers
end
