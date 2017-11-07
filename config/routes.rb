Rails.application.routes.draw do

  resources :customers
  resources :movies

  post '/rentals/check_out', to: 'rentals#check_out', as: 'checkout'
  post '/rentals/check_in', to: 'rentals#check_in', as: 'checkin'
  get '/rentals/overdue', to: 'rentals#overdue', as: 'overdue'
end
