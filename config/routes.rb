Rails.application.routes.draw do
  # get 'rentals/checkout'
  #
  # get 'rentals/checkin'
  #
  # get 'rentals/overdue'

  get 'customers/index'

  get 'movies/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index] do
    get '/rentals/overdue', to: 'rentals#overdue', as: 'rental_overdue'
  end

  resources :movies, only: [:index, :show, :create] do
    post '/rentals/checkout', to: 'rentals#checkout', as: 'rental_checkout'
    patch '/rentals/checkin', to: 'rentals#checkin', as: 'rental_checkin'
  end



end
