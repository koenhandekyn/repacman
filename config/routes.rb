Rails.application.routes.draw do
  # OAuth routes
  get "/auth/:provider/callback", to: "auth#callback"
  get "/auth/failure", to: "auth#failure"
  delete "/logout", to: "auth#logout"

  resources :batch_outputs
  resources :batch_inputs

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "home/home"
  get "home/login"

  resources :printeds do
    get :export, on: :collection
  end

  resources :batches do
    get :print, on: :member
  end
  resources :assemblies

  mount Motor::Admin => "/admin"
  root "home#home"
end
