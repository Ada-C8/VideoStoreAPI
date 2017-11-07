Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :movies, only: [:index, :show, :create]
resources :customers, only: [:index, :show]

get '/rentals/overdue', to:'rentals#overdue', as: 'rentals_overdue'
post '/rentals/checkout', to:'rentals#checkout', as: 'rentals_checkout'
post '/rental/checkin', to:'rentals#checkin', as: 'rentals_checkin'
# resources :rental
end
