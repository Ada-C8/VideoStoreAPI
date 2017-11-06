Rails.application.routes.draw do
  resources :customers, only: :index
  resources :movies, only: [:index, :show, :create]

  #make zomg test path
end
