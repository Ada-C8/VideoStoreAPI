Rails.application.routes.draw do

  post 'rentals/check-in', to: 'rentals#checkin', as: 'checkin'

  post 'rentals/check-out', to: 'rentals#checkout', as: 'checkout'

  get 'rentals/overdue', to: 'rentals#overdue', as: 'overdue'

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: :index

  # # get '/zomg', to: 'movies#zomg', as: zomg
  # resources :rentals, only: [:checkout, :checkin, :overdue]
end
