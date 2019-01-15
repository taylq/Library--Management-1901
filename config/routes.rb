Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "sessions/new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
      resources :borrows
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]

    resources :books, only: %i(index show)
    namespace :admin do
      resources :users
    end
  end
end
