# frozen_string_literal: true

class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show edit update destroy]
  before_action :set_categories_and_months, only: %i[new create edit update]

  def index
    @budgets = policy_scope(current_user.budgets.includes(:category))
    # TODO: Refactor this code, move budget spending calucation to budget model
    @spent_amounts = @budgets.map { |budget| calculate_spent(budget) }
  end

  def show
    authorize @budget
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

  def edit
    authorize @budget
  end

  def update
    authorize @budget

    if @budget.update(budget_params)
      redirect_to budgets_path, notice: 'Budget was successfully updated.'
    elsif @budget.errors[:base].include?('The budget already exists for this category and month. Please edit the existing budget.')
      existing_budget = current_user.budgets.find_by(category_id: budget_params[:category_id],
                                                     budget_month: budget_params[:budget_month])
      redirect_to edit_budget_path(existing_budget),
                  alert: 'The budget already exists for this category and month. Please edit the existing budget.'
    else
      render :edit, status: :unprocessable_entity
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
  end

  def budget_params
    params.require(:budget).permit(:amount, :category_id, :notes, :budget_month)
  end

  def set_categories_and_months
    @categories = Category.all
    @next_12_months = (0..11).map { |i| Time.now.beginning_of_month + i.months }
  end

  def calculate_spent(budget)
    Transaction.by_category_and_month(current_user, budget.category_id, budget.budget_month).sum(:amount)
  end
end
