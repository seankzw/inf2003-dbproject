Rails.application.routes.draw do
  get "errors/not_found"
  get "errors/internal_server_error"

  # mongodb
  resources :medicines
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
  get "/hospital", to:"hospitals#index"
  get "/clinic", to:"clinics#index"
  get "/patient", to:"patients#index"
  get "/doctor", to:"doctors#index"

  get "/meidicines", to:"meidicine#index"
  root "home#index"

end
