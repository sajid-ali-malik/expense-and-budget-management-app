# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @accounts = current_user.accounts.order(created_at: :desc).page(params[:page]).per(5)
    @budgets = current_user.budgets.order(created_at: :desc).includes(:category).page(params[:page]).per(5)
    @transactions = current_user.transactions.order(created_at: :desc).page(params[:page]).per(5)
    @categories = Category.all
    @spent_amounts = @budgets.map(&:spent_amount)
  end
end
