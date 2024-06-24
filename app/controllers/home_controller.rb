class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = current_user.accounts
    @budgets = current_user.budgets
  end
end
