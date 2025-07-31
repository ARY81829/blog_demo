Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :newsletter_subscriptions, only: [:create]

  get 'about', to: 'pages#about'
  get 'pages/home', to: 'pages#home'  # Kann bleiben, falls du /pages/home als URL möchtest

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"  # Startseite zeigt pages#home
end
