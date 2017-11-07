Rails.application.routes.draw do
  resources :movies, only: [:index, :show, :create]

  get 'customers/', to: 'customers#index', as: 'customers'

  post 'rentals/checkout', to: 'rentals#create', as: 'checkout'
  put 'rentals/:id/checkin', to: 'rentals#update', as: 'checkin'
  get 'rentals/overdues', to: 'rentals#index', as: 'rentals'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
