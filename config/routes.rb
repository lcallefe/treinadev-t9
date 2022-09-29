Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :warehouses, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :edit, :create, :update]
  resources :product_models, only: [:index , :new, :create, :show]
end
