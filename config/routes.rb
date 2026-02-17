Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  
  root 'home#index'
  
  resources :profiles, only: [:show, :edit, :update] do
    collection do
      get 'browse'
    end
  end
  
  resources :likes, only: [:create]
  
  resources :matches, only: [:index, :show] do
    resources :messages, only: [:index, :create]
  end
  
  resources :interests, only: [:index]
  
  # API endpoints for real-time features
  namespace :api do
    namespace :v1 do
      resources :matches, only: [] do
        resources :messages, only: [:index, :create]
      end
    end
  end
  
  mount ActionCable.server => '/cable'
end