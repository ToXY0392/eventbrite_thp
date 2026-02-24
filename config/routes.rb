Rails.application.routes.draw do
  root "events#index"

  devise_for :users

  resources :users, only: [:show], constraints: { id: /\d+/ }
  resources :events do
    resources :attendances, only: [:create]
  end

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end