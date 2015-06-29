require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/monitoring'

  root to: 'renotification#index'
  resources :templates
end
