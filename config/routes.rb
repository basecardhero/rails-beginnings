Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :registrations, only: %i[ new create ] do
    get "confirm/:token", action: :confirm, on: :collection, as: :confirm
  end

  get "profile" => "profile#index", as: :profile
  patch "profile" => "profile#update"
  patch "profile/password" => "profile#update_password", as: :profile_password
  patch "profile/email" => "profile#update_email", as: :profile_email
  patch "profile/email/send_confirmation" => "profile#send_email_confirmation", as: :profile_send_email_confirmation

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
