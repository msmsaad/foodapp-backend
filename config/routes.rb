# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  # TODO: sidekiq should be accessible behind the admin panel login
  mount Sidekiq::Web => "/admin/sidekiq"

  mount_devise_token_auth_for "User", at: "auth"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index]
      resources :meals, only: [:index]
      resource :cart, controller: :cart, only: [:show, :update] do
        get :checkout
      end

      resource :webhooks, only: [] do
        post :stripe
      end
    end
  end
end
