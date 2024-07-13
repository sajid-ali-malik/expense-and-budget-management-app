# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @accounts = current_user.accounts.order(created_at: :desc).page(params[:page]).per(5)
    @budgets = current_user.budgets.order(created_at: :desc).includes(:category).page(params[:page]).per(5)
    @transactions = current_user.transactions.order(created_at: :desc).page(params[:page]).per(5)
    @categories = Category.all
    @spent_amounts = @budgets.map { |budget| calculate_spent(budget) }
  end

  private

  def calculate_spent(budget)
    Transaction.by_category_and_month(current_user, budget.category_id, budget.budget_month).sum(:amount)
  end
end
