Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users

  resources :accounts
  resources :budgets

  root to: "home#index"

end
