require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/monitoring'

  resources :templates, except: :show
  resources :sequences, only: [:index, :create, :destroy] do
    get :sms, :email, :ios, :andriod, on: :collection
  end
  resources :programs, except: :show do
  end
  resources :settings, only: [:update] do
    patch :queries, :conditions, on: :collection
  end

  root to: 'sequences#index'
end
