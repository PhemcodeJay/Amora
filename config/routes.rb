Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Devise routes for user authentication
  devise_for :users
  
  # Authenticated root - users go to dashboard when logged in
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  
  # Unauthenticated root - visitors see home page
  root 'home#index'
  
  # Profile routes
  resources :profiles, only: [:show, :edit, :update] do
    collection do
      get 'browse'
    end
  end
  
  # Like routes
  resources :likes, only: [:create]
  
  # Match routes with nested messages
  resources :matches, only: [:index, :show] do
    resources :messages, only: [:index, :create]
  end
  
  # Interests
  resources :interests, only: [:index]
  
  # API endpoints for real-time features
  namespace :api do
    namespace :v1 do
      resources :matches, only: [] do
        resources :messages, only: [:index, :create]
      end
    end
  end
  
  # WebSocket for Action Cable
  mount ActionCable.server => '/cable'
end