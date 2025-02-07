Rails.application.routes.draw do
  get "public/index"
  devise_for :users

  authenticated :user do
    root to: "home#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "public#index", as: :unauthenticated_root
  end
end
