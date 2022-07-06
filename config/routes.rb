Rails.application.routes.draw do
  devise_for :users

  root "users#index"
  resources :orders do
    member do
      post :accept
      post :rate
      get :rate
      get :rate_page
      delete :cancel
      delete :skip_rate
    end
    collection do
      get :past
    end
  end
  resources :users do
    member do
      post :pick_up_passenger
      delete :cancel
      post :close
    end
  end
  resources :options
end
