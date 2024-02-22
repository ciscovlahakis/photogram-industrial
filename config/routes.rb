Rails.application.routes.draw do
  root "photos#index"

  get "/users/:id" => "users#show", as: :user

  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  get "/:username" => "users#show", as: :user
end
