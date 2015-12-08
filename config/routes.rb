Rails.application.routes.draw do

  devise_for :users

  root to: "home#index"
  get "timeline" => "home#timeline"

  resources :users, only: [:show]
end
