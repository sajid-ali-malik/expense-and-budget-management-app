Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users

  resources :accounts
  root to: "home#index"

end
