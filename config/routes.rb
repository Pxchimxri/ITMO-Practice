Rails.application.routes.draw do

  root "users#index"
  resources :orders #plural
  resources :users #plural
  resources :options #plural
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
