Rails.application.routes.draw do
  resources :drivers
  resources :students, only: [:create]
  get 'students', to: 'students#show'  
  post 'students/login', to: 'students#login'
  resources :journeys
  post 'journeys/:id/join', to: 'journeys#join_journey'
  post 'journeys/search', to: 'journeys#search'
  # post 'journey/:id/join/driver', to: 'journeys#join_driver'
  get '/transactions/search', to: 'transactions#search'
  resources :transactions
end