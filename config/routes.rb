Rails.application.routes.draw do
  devise_for :users

  root 'users#show'
  resources :orders do
    member do
      post :accept
      post :close
      post :rate
      get :rate
      get :rate_page
      delete :cancel
      delete :skip_rate
    end
    collection do
      get :dashboard
      get :looking_for_car
    end
  end
  resources :users do
    member do
      post :pick_up_passenger
    end
  end
  resources :options
end
