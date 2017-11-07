Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies, only: [:index, :show, :create]

  resources :customers, only: :index

  post '/rentals/check-out', to: 'rentals#check_out', as: 'checkout' #checkout_path

  post '/rentals/check-in', to: 'rentals#check_in', as:
  'checkin' #checkin_path

  get '/rentals/overdue', to: 'rentals#overdue', as: 'overdue' #overdue_path

  get '/zomg', to: 'movies#check', as: 'zomg' #zomg_path
end
