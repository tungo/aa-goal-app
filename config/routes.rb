Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :goals, only: [:index]
  resource :session, only: [:new, :create, :destroy]
  root 'goals#index', as: "root"
end
