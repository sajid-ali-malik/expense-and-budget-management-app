class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
<<<<<<< Updated upstream
    @accounts = current_user.accounts
    @budgets = current_user.budgets
=======
    @accounts = current_user.accounts.order(created_at: :desc).page(params[:page]).per(5)
    @budgets = current_user.budgets.order(created_at: :desc).page(params[:page]).per(5)
    @transactions = current_user.transactions.order(created_at: :desc).page(params[:page]).per(5)
    @categories = Category.all
>>>>>>> Stashed changes
  end
end
