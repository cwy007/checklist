Rails.application.routes.draw do
  get    'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  delete 'logout',  to: 'sessions#destroy'
  get    'welcome', to: 'pages#welcome'

  resources :users,    only: [:create]
  resources :sessions, only: [:create]
  resources :tasks
  
  root 'tasks#index'
end
