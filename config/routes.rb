Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :warehouses, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :edit, :create, :update]
  resources :product_models, only: [:index , :new, :create, :show]
  resources :orders, only: [:index , :new, :create, :show, :edit, :update, :index]

  namespace :api do 
    namespace :v1 do 
      resources :warehouses, only: [:show, :index]
    end 
  end
end
