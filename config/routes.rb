Rails.application.routes.draw do
  get "public/index"
  devise_for :users

  # Authenticated routes
  authenticated :user do
    root to: "home#index", as: :authenticated_root

    # Dashboard routes
    get "today", to: "home#index", as: :today
    get "balance", to: "dashboard#balance", as: :balance
    get "budget", to: "dashboard#budget", as: :budget

    # Settings routes
    get "settings/account", to: "settings#account", as: :account_settings

    # Transactions routes
    resources :transactions
    get "finances", to: "transactions#finances", as: :finances
  end

  # Unauthenticated routes
  unauthenticated do
    root to: "public#index", as: :unauthenticated_root
  end
end
