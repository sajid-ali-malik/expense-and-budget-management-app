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
    current_user.transactions
                .where(category_id: budget.category_id)
                .where('EXTRACT(MONTH FROM created_at) = ? AND EXTRACT(YEAR FROM created_at) = ?', budget.budget_month.month, budget.budget_month.year)
                .sum(:amount)
  end
end
