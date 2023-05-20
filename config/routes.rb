Rails.application.routes.draw do
  resources :medicines
  get "errors/not_found"
  get "errors/internal_server_error"

  # mongodb
  # postgres
  resources :hospitals
  resources :clinics
  resources :patients
  resources :doctors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  #Routes
  get "/hospitals", to:"hospitals#index"
  get "/clinics", to:"clinics#index"
  get "/patients", to:"patients#index"
  get "/doctors", to:"doctors#index"

  get "/medicines", to:"medicines#index"
  root "home#index"

end
