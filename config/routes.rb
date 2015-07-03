require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/monitoring'

  resources :templates, except: :show
  resources :programs, except: :show do
    resources :sequences, only: [:index, :create, :destroy] do
      get :sms, :email, :ios, :andriod, on: :collection
    end
  end
  resources :settings, only: [:update] do
    patch :queries, :conditions, on: :collection
  end

  root to: 'programs#index'
end
