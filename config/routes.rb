require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/monitoring'

  resources :queries, only: [:index, :show]
  resources :templates, except: :show
  resources :programs, except: :show do
    get :options, :users, on: :member
    resources :sequences, only: [:index, :create, :destroy] do
      get :sms, :email, :ios, :android, on: :collection
    end
  end
  resources :settings, only: [:update] do
    patch :queries, :conditions, on: :collection
  end

  root to: 'programs#index'
end
