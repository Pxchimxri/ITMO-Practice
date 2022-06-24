Rails.application.routes.draw do
  devise_for :users

  root "users#index"
  resources :orders, :users, :options
  resources :orders do
    member do
      delete :cancel
      post :accept
      get :rate_page
      post :rate
      get :rate
      delete :skip_rate
    end
  end
  resources :users do
    member do
      post :pick_up_passenger
      delete :cancel
      post :close
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
