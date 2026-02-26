Rails.application.routes.draw do
  root "events#index"

  devise_for :users

  resources :users, only: [:show], constraints: { id: /\d+/ } do
    resources :avatars, only: [:create]
  end
  
  resources :events do
    post "attendances/checkout", to: "attendances#checkout", as: :attendance_checkout
    get "attendances/success", to: "attendances#success", as: :attendance_success
    resources :attendances, only: [:create, :new, :index]
  end

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end