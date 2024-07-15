# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :accounts
  resources :budgets
  resources :transactions

  root to: 'home#index'
end
