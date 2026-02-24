Rails.application.routes.draw do
  root "events#index"

  devise_for :users

  resources :users, only: [:show]
  resources :events
  resources :attendances, only: [:create]

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end