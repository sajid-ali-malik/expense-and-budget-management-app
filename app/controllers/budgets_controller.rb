# frozen_string_literal: true

class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: %i[show edit update destroy]
  before_action :set_categories_and_months, only: %i[new create edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :budget_not_found

  def index
    @budgets = current_user.budgets
  end

  def show; end

  def new
    @budget = Budget.new
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.save
      redirect_to budgets_path, notice: 'Budget was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: 'Budget was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_path, notice: 'Budget was successfully destroyed.'
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  def budget_not_found
    redirect_to budgets_url, alert: 'Budget not found.'
  end

  def budget_params
    params.require(:budget).permit(:name, :amount, :category_id, :budget_month)
  end

  def set_categories_and_months
    @categories = Category.all
    @next_12_months = (0..11).map { |i| Time.now.beginning_of_month + i.months }
  end
end
