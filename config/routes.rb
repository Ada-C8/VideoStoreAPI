Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index, :zomg]
  resources :movies, only: [:index, :show, :create]
  # resources :zomg, only: [:index]


  post 'rentals/check-out', to: 'rentals#create', as: "check_out"
  post '/rentals/check-in', to: 'rentals#update', as: 'check_in'
end
