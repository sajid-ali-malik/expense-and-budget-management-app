class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show edit update destroy]
  before_action :set_categories_and_months, only: %i[new create edit update]

  def index
    @budgets = current_user.budgets
    @budgets = @budgets.by_month(params[:month]) if params[:month].present?
    @budgets = @budgets.by_category(params[:category_id]) if params[:category_id].present?
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
  rescue ActiveRecord::RecordNotFound
    budget_not_found
  end

  def budget_params
    params.require(:budget).permit(:name, :amount, :category_id, :budget_month)
  end

  def budget_not_found
    redirect_to budgets_url, alert: 'Budget not found.'
  end
end
