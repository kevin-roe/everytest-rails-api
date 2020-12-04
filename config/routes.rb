Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :register, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  put 'organizations', to: "organizations#update"
  resources :products, only: [:index, :create, :update, :destroy]
  resources :platforms, only: [:index, :create, :update, :destroy]
  resources :test_plans, only: [:index, :show, :create, :update, :destroy]
  resources :test_suites, only: [:index, :show, :create, :update, :destroy]
end