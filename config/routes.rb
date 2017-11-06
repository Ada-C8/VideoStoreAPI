Rails.application.routes.draw do
  resources :customers, only: :index
  resources :movies, only: [:index, :show, :create]

  #make zomg test path
  get '/zomg', to: 'customers#test', as: 'test'



end
