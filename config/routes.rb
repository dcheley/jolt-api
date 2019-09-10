Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users
      resources :merchants
      resources :merchants do
        resources :offers, only: [:index]
        resources :events, only: [:index]
        resources :advertisements, only: [:index]
        resources :billings, only: [:index, :create, :update, :destroy]
      end
      resources :offers, only: [:index, :create, :update, :destroy]
      resources :events, only: [:index, :create, :update, :destroy]
      resources :advertisements, only: [:create, :update, :destroy]
      resources :feedbacks, only: [:index, :create, :destroy]
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
