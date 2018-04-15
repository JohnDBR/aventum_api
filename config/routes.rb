Rails.application.routes.draw do
  resources :users, only: [:create]
  get 'users', to: 'users#show'  
  post 'login', to: 'users#login'
  resources :journeys
  post 'journeys/:id/join', to: 'journeys#join_journey'
  post 'journeys/search', to: 'journeys#search'
  resources :transactions
end