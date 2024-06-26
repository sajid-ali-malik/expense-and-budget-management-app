class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
   @transactions = current_user.transactions
  end

  def show
  end

  def edit
  end

  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
    @labels = Label.all
  end


  def create
  ActiveRecord::Base.connection.clear_cache!

    @transaction = transaction_type.constantize.new(transaction_params)
    @transaction.user = current_user

    if @transaction.save
      redirect_to root_path, notice: 'Transaction was successfully created.'
    else
      @accounts = current_user.accounts
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @transaction.destroy
    redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
  end


  private

  def transaction_type
    params[:transaction][:type]
  end

  def transaction_params
    params.require(:transaction).permit(:type, :amount, :source_account_id, :destination_account_id, :description, :location, :label_id, :date)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
