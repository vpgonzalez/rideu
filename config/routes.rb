Rails.application.routes.draw do
  get "vehicles/new"
  get "vehicles/create"
  devise_for :users
  root to: "home#index"
  resources :trips, only: [:index, :new, :create, :show]
  resource :profile, only: [:show, :edit, :update]
  resources :vehicles, only: [:new, :create]
end