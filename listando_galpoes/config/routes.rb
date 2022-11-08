Rails.application.routes.draw do
<<<<<<< HEAD
  root to: "warehouses#index"
=======
  devise_for :users
  root "home#index"
  resources :warehouses, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :edit, :create, :update]
  resources :product_models, only: [:index , :new, :create, :show]
  resources :orders, only: [:index , :new, :create, :show, :edit, :update, :index]

  namespace :api do 
    namespace :v1 do 
      resources :warehouses, only: [:show, :index, :create]
    end 
  end
>>>>>>> 015da33165c05d6f2af0455957a6c0ef3e4a2126
end
