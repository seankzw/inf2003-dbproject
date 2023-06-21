Rails.application.routes.draw do
  devise_for :users
  get "errors/not_found"
  get "errors/internal_server_error"

  # mongodb
  resources :medicines

  # postgres
  resources :hospitals
  resources :clinics
  resources :patients
  resources :doctors
  resources :appointments
  resources :administrators
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  #Routes
  get "/hospitals", to:"hospitals#index"
  get "/clinics", to:"clinics#index"
  get "/patients", to:"patients#index"
  get "/doctors", to:"doctors#index"
  get "/adminstrators", to:"administrators#index"

  get "/medicines", to:"medicines#index"
  root "hospitals#index"

end
