Rails.application.routes.draw do
  root "home#index"
  resources :warehouses, only: [:new, :create, :show]
end
