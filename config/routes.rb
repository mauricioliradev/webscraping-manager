Rails.application.routes.draw do
  get "dashboard/index"
  # Rotas de Autenticação
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Dashboard
  root 'dashboard#index'
  
  get '/up', to: 'rails/health#show', as: :rails_health_check
end