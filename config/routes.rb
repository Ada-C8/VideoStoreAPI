Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show, :create]

  post '/rentals/check-out/:id', to: 'rentals#check_out', as: "checkout"
  post '/rentals/check-in/:id', to: 'rentals#check_in', as: "checkin"
  get '/rentals/overdue/:id', to: 'rentals#overdue', as: "overdue"
end
