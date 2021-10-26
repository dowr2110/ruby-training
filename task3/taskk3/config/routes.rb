Rails.application.routes.draw do
  resources :orders, only: [:index, :show, :create, :update, :destroy]
  resources :phones, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :providers, only: [:index, :show, :create, :update, :destroy]
  resources :companies, only: [:index, :show, :create, :update, :destroy]
end
