Rails.application.routes.draw do

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root to: "posts#index"

  devise_for :users

  resources :posts

  resources :users

  get 'pdf_generator/generate_pdf', to: 'pdf_generator#generate_pdf', as: :generate_pdf

  get 'pdf_generator', to: 'pdf_generator#index'

end
