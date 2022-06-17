Rails.application.routes.draw do

  root "users#index"
  resources :orders, :users, :options
  resources :orders do
    member do
      get :cancel
      put :cancel
      get :accept
      put :accept
    end
  end
  resources :users do
    member do
      get :cancel
      put :cancel
      get :close
      put :close
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
