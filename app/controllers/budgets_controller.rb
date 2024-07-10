# frozen_string_literal: true

class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: %i[show edit update destroy]
  before_action :set_category_id, only: %i[index show]

  rescue_from ActiveRecord::RecordNotFound, with: :budget_not_found

  def index
    @budgets = current_user.budgets
  end

  def show; end

  def new
    @budget = Budget.new
    @categories = Category.all
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    set_month_and_year(@budget)
    if @budget.save
      redirect_to root_path, notice: 'Budget was successfully created.'
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @budget.update(budget_params)
      set_month_and_year(@budget)
      if @budget.save
        redirect_to @budget, notice: 'Budget was successfully updated.'
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_url, notice: 'Budget was successfully destroyed.'
  end

  private

  def set_category_id
    @expenses_by_category = current_user.transactions.where(type: 'Transactions::Expense').group(:category_id, :month,
                                                                                                 :year).sum(:amount)
  end

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  def budget_not_found
    redirect_to budgets_url, alert: 'Budget not found.'
  end

  def budget_params
    params.require(:budget).permit(:name, :amount, :category_id, :period, :month, :year)
  end

  def set_month_and_year(budget)
    now = Time.now
    budget.month = now.month
    budget.year = now.year
  end
end
