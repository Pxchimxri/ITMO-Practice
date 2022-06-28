Rails.application.routes.draw do
  devise_for :users

  root 'users#show'
  resources :orders, :users, :options
  resources :orders do
    member do
      delete :cancel
      post :accept
      post :close
    end
  end
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
