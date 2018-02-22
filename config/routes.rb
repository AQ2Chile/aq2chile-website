Rails.application.routes.draw do
  get '/rankings', to: 'rankings#index'
  get '/downloads', to: 'home#downloads'
  root to: 'home#index'
end
