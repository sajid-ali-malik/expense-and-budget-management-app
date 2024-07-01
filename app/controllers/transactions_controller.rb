class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:edit, :update, :destroy]

  def edit
    @accounts = current_user.accounts
  end

  def update
    revert_account_updates(@transaction)
    if @transaction.update(transaction_params)
      update_account_balances(@transaction)
      redirect_to transactions_path, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end


  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
    @labels = Label.all
  end

  def create
    transaction_type = transaction_params[:type]
    @transaction = transaction_type.constantize.new(transaction_params)
    @transaction.user = current_user

    ActiveRecord::Base.transaction do
      if @transaction.save
        handle_account_updates(@transaction)
        redirect_to root_path, notice: 'Transaction was successfully created.'
      else
        @accounts = current_user.accounts
        @labels = Label.all
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      revert_account_updates(@transaction)
      @transaction.destroy
      redirect_to root_path, notice: 'Transaction was successfully deleted.'
    end
  end


  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:type, :amount, :source_account_id, :destination_account_id, :description, :location)
  end

  def revert_account_updates(transaction)
    if transaction.is_a?(Transactions::Transfer)
      transaction.source_account.update(balance: transaction.source_account.balance + transaction.amount)
      transaction.destination_account.update(balance: transaction.destination_account.balance - transaction.amount)
    elsif transaction.is_a?(Transactions::Income)
      transaction.destination_account.update(balance: transaction.destination_account.balance - transaction.amount)
    elsif transaction.is_a?(Transactions::Expense)
      transaction.source_account.update(balance: transaction.source_account.balance + transaction.amount)
    end
  end

  def update_account_balances(transaction)
    if transaction.is_a?(Transactions::Transfer)
      transaction.source_account.update(balance: transaction.source_account.balance - transaction.amount)
      transaction.destination_account.update(balance: transaction.destination_account.balance + transaction.amount)
    elsif transaction.is_a?(Transactions::Income)
      transaction.destination_account.update(balance: transaction.destination_account.balance + transaction.amount)
    elsif transaction.is_a?(Transactions::Expense)
      transaction.source_account.update(balance: transaction.source_account.balance - transaction.amount)
    end
  end
end
