class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = current_user.accounts.order(created_at: :desc).page(params[:page]).per(5)
    @budgets = current_user.budgets.order(created_at: :desc).page(params[:page]).per(5)
    @transactions = current_user.transactions.order(created_at: :desc).page(params[:page]).per(5)
  end
end
