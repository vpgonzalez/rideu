Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  resource :profile, only: [:show, :edit, :update]
  resources :vehicles, only: [:new, :create]

  resources :trips, only: [:index, :new, :create, :show, :destroy] do
    resources :reservations, only: [:create]
  end
end