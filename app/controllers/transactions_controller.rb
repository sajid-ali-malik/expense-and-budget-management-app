# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[edit update destroy show]

  def index
    @sort_order = params[:sort] || 'desc'
    @transactions = current_user.transactions.order(created_at: @sort_order).page(params[:page]).per(5)

    if params[:source_account_id].present?
      @transactions = @transactions.where(source_account_id: params[:source_account_id])
    end

    if params[:destination_account_id].present?
      @transactions = @transactions.where(destination_account_id: params[:destination_account_id])
    end

    @transactions = @transactions.where(type: params[:type]) if params[:type].present?

    @accounts = current_user.accounts
  end

  def edit
    @accounts = current_user.accounts
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

  def update
    @transaction = Transaction.find(params[:id])
    @categories = Category.all

    RevertAccountBalance.new(@transaction).call

    if @transaction.update(transaction_params)
      UpdateAccountBalance.new(@transaction).call
      set_month_and_year(@transaction)
      redirect_to transactions_path, notice: 'Transaction was successfully updated.'
    else
      @accounts = current_user.accounts
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
    @categories = Category.all
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    set_month_and_year(@transaction)

    if @transaction.save
      UpdateAccountBalance.new(@transaction).call
      redirect_to transactions_path, notice: 'Transaction was successfully created.'
    else
      @accounts = current_user.accounts
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      RevertAccountBalance.new(@transaction).call
      @transaction.destroy
      redirect_to root_path, notice: 'Transaction was successfully deleted.'
    end
  end

  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:type, :amount, :source_account_id, :destination_account_id, :description,
                                        :location, :category_id)
  end

  def transaction_type_param
    params[:transaction][:type]
  end

  def set_month_and_year(transaction)
    now = Time.now
    transaction.month = now.month
    transaction.year = now.year
  end
end
