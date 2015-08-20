Rails.application.routes.draw do
  #
  # concerns
  #

  concern :messages do
    resources :messages, only: [] do
      get :in_queue, :sent, :error, :canceled, on: :collection
    end
  end

  #
  # resources
  #

  resources :queries, only: [:index, :show]
  resources :users, only: [:show]
  concerns  :messages

  resources :templates, except: :show do
    resources :localized, only: [:new, :create, :edit, :update, :destroy], module: 'templates'
  end

  resources :programs, except: :show do
    get :options, :users, on: :member
    resources :delayed_templates, only: [:index, :create, :destroy] do
      get :sms, :email, :ios, :android, on: :collection
    end
    resources :tests, only: [] do
      post :run, on: :member
    end
    concerns :messages
  end

  resources :settings, only: [:update] do
    patch :queries, :conditions, on: :collection
  end

  resources :sessions, only: [:index, :create] do
    get :reset, on: :collection
  end

  #
  # other stuff
  #

  root to: 'dashboard#index'

  get 'status', to: Proc.new { [200, {}, ['']] }
end
