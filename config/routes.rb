Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :promotions
      resources :merchants
      resources :users

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
