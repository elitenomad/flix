Flix::Application.routes.draw do

  resources :favourites

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  resource :session, only:[:new,:create,:destroy]

  get "signup", to:'users#new'
  get "signin", to:'sessions#new'
  delete "signout", to:'sessions#destroy'

  resources :users

  root "movies#index"
  resources :movies do
  	resources :reviews
  end



end
