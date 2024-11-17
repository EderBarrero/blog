Rails.application.routes.draw do
  get 'render/index'
  devise_for :users

  root "render#index"
  
  resources :posts 

end
