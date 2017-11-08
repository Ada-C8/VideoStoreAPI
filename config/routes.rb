Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]

  resources :rentals, only: [:create, :update]

  # patch '/rentals/:id', to: "rentals#checkin", as: 'rental_checkin'
end
