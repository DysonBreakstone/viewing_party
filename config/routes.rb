Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "application#welcome"

  get "/register", to: "users#new"
  get "/dashboard", to: "users#dashboard"
  get "/discover", to: "movies#discover"
  get "/user_parties/create", to: "user_parties#create"
  get "/login", to: "users#login_form"
  delete "/logout", to: "sessions#destroy"
  post "/login", to: "sessions#login_user"

  resources :users, only: [:create, :show]
  resources :movies, only: [:index, :show] do
    resources :parties, only: [:new, :create]
  end

  namespace :admin do
    get "/dashboard", to: "users#dashboard"
    resources :users, only: [:show]
  end
end
