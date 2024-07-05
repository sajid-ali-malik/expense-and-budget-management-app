Rails.application.routes.draw do
  devise_for :users

  resources :accounts
  resources :budgets
  resources :transactions

  namespace :transactions do
    resources :expenses, controller: 'expenses', type: 'Transactions::Expense'
    resources :incomes, controller: 'incomes', type: 'Transactions::Income'
    resources :transfers, controller: 'transfers', type: 'Transactions::Transfer'
  end

  root to: "home#index"
end
