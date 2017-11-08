Rails.application.routes.draw do

  resources :customers
  resources :movies

  post '/rentals/check_out/:movie_id/:customer_id', to: 'rentals#check_out', as: 'checkout'
  post '/rentals/check_in/:rental_id', to: 'rentals#check_in', as: 'checkin'
  get '/rentals/overdue', to: 'rentals#overdue', as: 'overdue'
  get '/rentals/create', to: 'rentals#create', as: 'new_rental'
end
