Rails.application.routes.draw do

  get '/customers', to: "customers#index", as: "customers"

  get '/movies', to: "movies#index", as: "movies"
  get '/movies/:id', to: 'movies#show', as: 'movie'
  post '/movies', to: 'movies#create', as: 'create_movie'

  get '/rentals/overdue', to: 'rentals#overdue', as: 'overdue_rentals'
  post '/rentals/check-out', to: 'rentals#create', as: 'create_rental'
  post '/rentals/check-in', to: 'rentals#update', as: 'update_rental'
end
