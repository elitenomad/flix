Flix::Application.routes.draw do
  root "movies#index"
  resources :genres

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  resource :session, only:[:new,:create,:destroy]

  get "signup", to:'users#new'
  get "signin", to:'sessions#new'
  delete "signout", to:'sessions#destroy'

  resources :users

  #%w(hits flops).each do |scope|
  #  get "movies/filter/#{scope}", to: "movies#index",  as: "filtered_movies"
  #  #get "movies/filter/flops", to: "movies#index", scope: 'flops'
  #end

  get "movies/filter/:scope", to: "movies#index", as: "filtered_movies"

  resources :movies do
  	resources :reviews
    resources :favourites
  end

end
