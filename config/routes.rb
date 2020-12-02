Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :register, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  put 'organizations/:id', to: "organizations#update"
  resources :products, path: "products/:organization_id", only: [:index, :create, :update, :destroy]
  resources :platforms, path: "platforms/:organization_id", only: [:index, :create, :update, :destroy]
  resources :test_plans, path: "testplans/:organization_id", only: [:index, :show, :create, :update, :destroy]
end