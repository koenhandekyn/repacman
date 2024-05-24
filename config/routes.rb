Rails.application.routes.draw do

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'home/home'

  resources :printeds do
    get :export, on: :collection
  end
  resources :families
  resources :labels
  resources :plants
  resources :bags
  resources :products

  mount Motor::Admin => '/admin'
  root 'home#home'
end
