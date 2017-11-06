Rails.application.routes.draw do

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: :index

  # get '/zomg', to: 'movies#zomg', as: zomg
end
