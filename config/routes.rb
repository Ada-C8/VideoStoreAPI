Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/zomg', to: 'movies#zomg'
  get '/rentals/checkout', to: 'rentals#checkout', as: 'checkout'
  
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show, :create]

end
