Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :register, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  put 'organizations', to: "organizations#update"
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :products, only: [:index, :show, :create, :update, :destroy]
  resources :platforms, only: [:index, :create, :update, :destroy]
  resources :test_plans, only: [:show, :create, :update, :destroy, :index]
  get 'test_plans/:test_plan_id/test_suites', to: "test_suites#index"
  resources :test_suites, only: [:show, :create, :update, :destroy]
  get 'test_suites/:test_suite_id/test_cases', to: "test_cases#index"
  resources :test_cases, only: [:show, :create, :update, :destroy]
  get 'test_cases/:test_case_id/test_steps', to: "test_steps#index"

  resources :workflows, only: [:show, :create, :update, :destroy]
  get 'products/:product_id/workflows', to: "workflows#index"
  resources :workflow_steps, only: [:show, :create, :update, :destroy]
  get 'workflows/:workflow_id/workflow_steps', to: "workflow_steps#index"

  get 'heartbeat', to: 'heartbeat#show'
end