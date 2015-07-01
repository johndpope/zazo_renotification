require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/monitoring'

  resources :templates, except: :show
  resources :sequences, only: [:index, :create, :destroy] do
    get :sms, :email, :ios, :andriod, on: :collection
  end
  resources :settings, only: [:index, :update]

  root to: 'sequences#index'
end
