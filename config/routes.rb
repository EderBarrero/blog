Rails.application.routes.draw do
  get 'render/index'
  devise_for :users

  root to: "posts#index"

  resources :posts

  resources :users
end
