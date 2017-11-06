Rails.application.routes.draw do
  resources :movies, only: [:index, :show, :create]

  get 'customers/', to: 'customers#index', as: 'customers'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
