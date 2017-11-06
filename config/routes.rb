Rails.application.routes.draw do
  get 'customers/index'

  get 'movies/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]
end
