Rails.application.routes.draw do
  root "photos#index"
  
  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  get ":username/liked" => "users#liked", as: :liked
  get ":username/feed"
  get ":username/followers"
  get ":username/following"
  get "/:username" => "users#show", as: :user
end
