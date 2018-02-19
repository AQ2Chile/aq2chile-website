Rails.application.routes.draw do
  get '/rankings', to: 'rankings#index'
  root to: 'home#index'
end
