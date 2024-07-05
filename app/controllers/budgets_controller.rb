class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  def index
    @budgets = current_user.budgets
    @categories = Category.all
  end

  def show
  end

  def new
    @budget = current_user.budgets.build
    @categories = Category.all
  end

  def create
    @budget = current_user.budgets.build(budget_params)
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
      redirect_to @budget, notice: 'Budget was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_url, notice: 'Budget was successfully destroyed.'
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:name, :amount, :category_id, :period)
  end
end
