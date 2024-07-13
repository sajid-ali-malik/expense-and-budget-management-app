class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[edit update destroy show]
  before_action :set_accounts_and_categories, only: %i[new edit update create show]

  def index
    @transactions = policy_scope(FetchTransactionsService.new(current_user, params).call)
    @accounts = current_user.accounts
  end

  def edit
    authorize @transaction
  end

  def show
    authorize @transaction
  end

  def update
    authorize @transaction

    RevertAccountBalance.new(@transaction).call

    if @transaction.update(transaction_params)
      UpdateAccountBalance.new(@transaction).call
      redirect_to transactions_path, notice: 'Transaction was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)

    if @transaction.save
      UpdateAccountBalance.new(@transaction).call
      redirect_to transactions_path, notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @transaction

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
end
