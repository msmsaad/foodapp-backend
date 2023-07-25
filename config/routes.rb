# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "auth"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index]
      resources :meals, only: [:index]
      resource :cart, controller: :cart, only: [:show, :update]
    end
  end
end
