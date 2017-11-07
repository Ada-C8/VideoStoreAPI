Rails.application.routes.draw do

  get '/customers', to: "customers#index", as: "customers"

  get '/movies', to: "movies#index", as: "movies"
  get '/movies/:id', to: 'movies#show', as: 'movie'
  post '/movies', to: 'movies#create', as: 'create_movie'

end
