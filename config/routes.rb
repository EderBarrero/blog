Rails.application.routes.draw do

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root to: "posts#index"

  devise_for :users

  resources :posts

  resources :users
end
