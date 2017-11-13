Rails.application.routes.draw do

post 'rentals/checkin', to: 'rentals#check_in', as: 'rentals_check_in'
post 'rentals/checkout', to: 'rentals#check_out', as: 'rentals_check_out'
resources :rentals
resources :customers, :movies, only: [:index, :show, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get '/zomg', to: 'application#zomg', as:'zomg'
end
