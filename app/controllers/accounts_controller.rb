class AccountsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :account_not_found

  def index
    @accounts = current_user.accounts
  end

  def show
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
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_path, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to root_path, notice: 'Account was successfully deleted.'
  end

private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_not_found
    flash[:alert] = 'The account you were looking for could not be found.'
    redirect_to accounts_path
  end

  def account_params
    params.require(:account).permit(:name, :account_number, :account_type, :currency, :color)
  end
end
