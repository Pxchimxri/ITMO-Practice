Rails.application.routes.draw do

  root "users#index"
  resources :orders, :users, :options
  resources :orders do
    member do
      delete :cancel
      post :accept
    end
  end
  resources :users do
    member do
      delete :cancel
      delete :close
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
