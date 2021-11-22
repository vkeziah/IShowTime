# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :movies, only: [:index, :create]
      resources :metrics, only: [:index]

      devise_for :users, controllers: {
        registrations: 'api/v1/registrations'
      }
    end
  end
end
