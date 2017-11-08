Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'customers', to: "customers#index", as: 'customers'

  get 'movies', to: 'movies#index', as: 'movies'
  get 'movies/:id', to: 'movies#show', as: 'movie'
  post 'movies', to: 'movies#create'

  post 'rentals/checkout', to: 'rentals#checkout', as: 'checkout'
  post 'rentals/check_in', to: 'rentals#check_in', as: 'check_in'

end
