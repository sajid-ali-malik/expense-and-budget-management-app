# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]
  before_action :set_transactions, only: %i[show]

  def index
    @accounts = policy_scope(Account)
  end

  # TODO: Display past month's transactions when showing the account.
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
      render :new, status: :unprocessable_entity
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
      render :edit, status: :unprocessable_entity
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
  end

  def account_params
    params.require(:account).permit(:name, :account_number, :account_type, :balance)
  end

  def set_transactions
    @transactions = Transaction.where(source_account_id: @account.id).or(Transaction.where(destination_account_id: @account.id)).page(params[:page]).per(10)
  end
end
