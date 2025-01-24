Rails.application.routes.draw do
  get "home/index"
  devise_for :users

  # Routes
  root "home#index"
  get "home", to: "home#index", as: "home"
end
