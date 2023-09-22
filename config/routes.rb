Rails.application.routes.draw do
  root 'home#index'

  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new, :create, :destroy]

  get "welcome", to: "sessions#welcome"
  # get "authorized", to: "sessions#page_requires_login"
  
  resources :books
  resources :users
  
  get '/profile', to: 'profile#show', as: :user_profile
end
