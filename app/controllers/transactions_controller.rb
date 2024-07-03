class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:edit, :update, :destroy, :show]

  def index
    @transactions = current_user.transactions.order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @accounts = current_user.accounts
  end

  def show
  end

  def update
    @transaction = Transaction.find(params[:id])

    ActiveRecord::Base.transaction do
      revert_account_updates(@transaction)

      if @transaction.update(transaction_params)
        handle_account_updates(@transaction)
        redirect_to transactions_path, notice: 'Transaction was successfully updated.'
      else
        @accounts = current_user.accounts
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
    @labels = Label.all
  end

  def create
    transaction_type = transaction_type_param
    @transaction = current_user.transactions.new(transaction_params.except(:type))
    @transaction.type = transaction_type

    if @transaction.save
      debugger
      handle_account_updates(Transaction.find(@transaction.id))
      redirect_to transactions_path, notice: 'Transaction was successfully created.'
    else
      @accounts = current_user.accounts
      @labels = Label.all
      render :new, status: :unprocessable_entity
    end
    ActiveRecord::Base.transaction do

    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      revert_account_updates(@transaction)
      @transaction.destroy
      redirect_to transactions_path, notice: 'Transaction was successfully deleted.'
    end
  end

  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:type, :amount, :source_account_id, :destination_account_id, :description, :location, :label_id)
  end

  def transaction_type_param
    params[:transaction][:type]
  end

  def handle_account_updates(transaction)
    Rails.logger.debug "Handling account updates for transaction ID: #{transaction.id} Transaction_type: #{transaction.type}"
    if transaction.is_a?(Transactions::Transfer)
      update_account_balance(transaction.source_account, -transaction.amount)
      update_account_balance(transaction.destination_account, +transaction.amount)
    elsif transaction.is_a?(Transactions::Income)
      update_account_balance(transaction.destination_account, +transaction.amount)
    elsif transaction.is_a?(Transactions::Expense)
      update_account_balance(transaction.source_account, -transaction.amount)
    end
  end

  def revert_account_updates(transaction)
    Rails.logger.debug "Reverting account updates for transaction ID: #{transaction.id} Transaction_type: #{transaction.type}"

    if transaction.is_a?(Transactions::Transfer)
      update_account_balance(transaction.source_account, +transaction.amount)
      update_account_balance(transaction.destination_account, -transaction.amount)
    elsif transaction.is_a?(Transactions::Income)
      update_account_balance(transaction.destination_account, -transaction.amount)
    elsif transaction.is_a?(Transactions::Expense)
      update_account_balance(transaction.source_account, +transaction.amount)
    end
  end

  def update_account_balance(account, amount)
    # return unless account

    new_balance = account.balance + amount
    account.update!(balance: new_balance)

  end

end
