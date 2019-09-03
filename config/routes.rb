Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users
      resources :merchants
      resources :merchants do
        resources :offers, only: [:index]
        resources :promotions, only: [:index]
      end
      resources :offers
      resources :promotions, only: [:create, :update, :destroy]
      resources :feedbacks, only: [:create, :destroy, :index]
      get "search_merchants", to: "merchants#search_merchants"
    end
  end

  root to: "home#index"

  # Authentication routes
  post "refresh", to: "refresh#create"
  post "signup", to: "signup#create"
  post "signin", to: "signin#create"
  delete "signout", to: "signin#destroy"
end
