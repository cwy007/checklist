Rails.application.routes.draw do
  get    'signup', to: 'users#new',        as: 'signup'
  get    'login',  to: 'sessions#new',     as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users,    only: [:create]
  resources :sessions, only: [:create]
  resources :tasks
  root 'tasks#index'
end
