Rails.application.routes.draw do
  resources :users
  post 'login', to: 'users#login'
  resources :journeys
  post 'journeys/:id/join', to: 'journeys#join_journey'
  resources :transactions
end