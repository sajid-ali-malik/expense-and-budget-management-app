# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = current_user.accounts.order(created_at: :desc).page(params[:page]).per(5)
    @budgets = current_user.budgets.order(created_at: :desc).page(params[:page]).per(5)
    @transactions = current_user.transactions.order(created_at: :desc).page(params[:page]).per(5)
    @expenses_by_category = current_user.transactions.where(type: 'Transactions::Expense').group(:category_id, :month,
                                                                                                 :year).sum(:amount)
    @categories = Category.all
  end
end
