Rails.application.routes.draw do
  get "public/index"
  devise_for :users

  # Authenticated routes
  authenticated :user do
    root to: "home#index", as: :authenticated_root

    get "today", to: "dashboard#today", as: :today
    get "balance", to: "dashboard#balance", as: :balance
    get "budget", to: "dashboard#budget", as: :budget
    get "settings/account", to: "settings#account", as: :account_settings
  end

  # Unauthenticated routes
  unauthenticated do
    root to: "public#index", as: :unauthenticated_root
  end
end
