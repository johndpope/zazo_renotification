Rails.application.routes.draw do
  resources :queries, only: [:index, :show]
  resources :templates, except: :show

  resources :programs, except: :show do
    get :options, :users, :test, on: :member
    resources :delayed_templates, only: [:index, :create, :destroy] do
      get :sms, :email, :ios, :android, on: :collection
    end
  end

  resources :settings, only: [:update] do
    patch :queries, :conditions, on: :collection
  end

  resources :sessions, only: [:index, :create] do
    get :reset, on: :collection
  end

  root to: 'dashboard#index'

  get 'status', to: Proc.new { [200, {}, ['']] }
end
