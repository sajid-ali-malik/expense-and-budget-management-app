class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show edit update destroy]
  before_action :set_categories_and_months, only: %i[new create edit update]

  def index
    @budgets = policy_scope(Budget)
  end

  def show
    authorize @budget
  end

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

  def edit
    authorize @budget
  end

  def update
    authorize @budget

    if @budget.update(budget_params)
      redirect_to budgets_path, notice: 'Budget was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @budget

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
    flash[:alert] = 'The budget you were looking for could not be found.'
    redirect_to budgets_url
  end

  def set_categories_and_months
    @categories = Category.all
    @next_12_months = (0..11).map { |i| Time.now.beginning_of_month + i.months }
  end
end
