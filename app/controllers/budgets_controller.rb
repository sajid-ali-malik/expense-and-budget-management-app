class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show edit update destroy]
  before_action :set_categories_and_months, only: %i[new create edit update]

  def index
    @budgets = current_user.budgets.includes(:category)
    @spent_amounts = @budgets.map { |budget| calculate_spent(budget) }
  end

  def show
    @spent = calculate_spent(@budget)
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.save
      redirect_to budgets_path, notice: 'Budget was successfully created.'
    elsif @budget.errors[:base].include?('The budget already exists for this category and month. Please edit the existing budget.')
      existing_budget = current_user.budgets.find_by(category_id: budget_params[:category_id],
                                                     budget_month: budget_params[:budget_month])
      redirect_to edit_budget_path(existing_budget),
                  alert: 'The budget already exists for this category and month. Please edit the existing budget.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: 'Budget was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
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

  def budget_params
    params.require(:budget).permit(:amount, :category_id, :notes, :budget_month)
  end

  def set_categories_and_months
    @categories = Category.all
    @next_12_months = (0..11).map { |i| Time.now.beginning_of_month + i.months }
  end

  def calculate_spent(budget)
    current_user.transactions
                .where(category_id: budget.category_id)
                .where('EXTRACT(MONTH FROM created_at) = ? AND EXTRACT(YEAR FROM created_at) = ?', budget.budget_month.month, budget.budget_month.year)
                .sum(:amount)
  end
end
