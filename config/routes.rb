Rails.application.routes.draw do
  resources :medicines
  resources :hospitals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  # root "home#index"
   get "/hospitals", to:"hospital#index"
   get "/meidicnes", to:"meidicine#index"
  #root "hospital#index"

end
