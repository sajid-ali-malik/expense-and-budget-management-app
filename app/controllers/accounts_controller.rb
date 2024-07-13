class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]

  def index
    @accounts = policy_scope(Account)
  end

  def show
    authorize @account
  end

  def new
    @account = current_user.accounts.new
  end

  def create
    @account = current_user.accounts.build(account_params)

    if @account.save
      redirect_to accounts_path, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @account
  end

  def update
    authorize @account

    if @account.update(account_params)
      redirect_to accounts_path, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @account

    @account.destroy
    redirect_to root_path, notice: 'Account was successfully deleted.'
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    account_not_found
  end

  def account_params
    params.require(:account).permit(:name, :account_number, :account_type, :balance)
  end

  def account_not_found
    flash[:alert] = 'The account you were looking for could not be found.'
    redirect_to accounts_path
  end
end
