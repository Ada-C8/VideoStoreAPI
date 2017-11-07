Rails.application.routes.draw do
  # get 'rentals/checkout'
  #
  # get 'rentals/checkin'
  #
  # get 'rentals/overdue'

  get 'customers/index'

  get 'movies/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]

  resources :movies, only: [:index, :show, :create]

  post '/rentals/check-out', to: 'rentals#checkout', as: 'rental_checkout'
  post '/rentals/:id/check-in', to: 'rentals#checkin', as: 'rental_checkin'

  get '/rentals/overdue', to: 'rentals#overdue', as: 'rental_overdue'



end
