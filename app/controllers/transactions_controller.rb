# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[edit update destroy show]
  before_action :set_accounts_and_categories, only: %i[new edit update create show index]
  before_action :set_params_for_filter_service, only: %i[index]

  def index
    @transactions = policy_scope(FetchTransactionsService.new(current_user, params).call)
  end

  def edit
  end

  def show
    authorize @transaction
  end

  def update
    authorize @transaction

    ActiveRecord::Base.transaction do
      RevertAccountBalance.new(@transaction).call

      if @transaction.update(transaction_params)
        UpdateAccountBalance.new(@transaction).call
        redirect_to transactions_path, notice: 'Transaction was successfully updated.'
      elsif @transaction.errors[:base].include?('Source account and destination account must be different')
        redirect_to edit_transaction_path,
                    alert: 'Source account and destination account must be different'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    ActiveRecord::Base.transaction do
      if @transaction.save
        UpdateAccountBalance.new(@transaction).call
        redirect_to transactions_path, notice: 'Transaction was successfully created.'
      elsif @transaction.errors[:base].include?('Source account and destination account must be different')
        redirect_to new_transaction_path,
                    alert: 'Source account and destination account must be different'

      else
        render :new, status: :unprocessable_entity
      end
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

  def set_accounts_and_categories
    @accounts = current_user.accounts
    @categories = Category.all
  end

  def set_params_for_filter_service
    params.permit(:source_account_id, :destination_account_id, :type,
                  :category_id, :sort, :page)
  end
end
