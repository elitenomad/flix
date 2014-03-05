Flix::Application.routes.draw do

  get "signup", to:'users#new'
  resources :users

  root "movies#index"
  resources :movies do
  	resources :reviews
  end



end
