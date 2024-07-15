# frozen_string_literal: true

class RevertAccountBalance
  def initialize(transaction)
    @transaction = transaction
  end

  def call
    ActiveRecord::Base.transaction do
      revert_account_updates
    end
  end

  private

  def revert_account_updates
    case @transaction
    when Transactions::Transfer
      update_account_balance(@transaction.source_account, +@transaction.amount)
      update_account_balance(@transaction.destination_account, -@transaction.amount)
    when Transactions::Income
      update_account_balance(@transaction.destination_account, -@transaction.amount)
    when Transactions::Expense
      update_account_balance(@transaction.source_account, +@transaction.amount)
    end
  end

  def update_account_balance(account, amount)
    return unless account

    new_balance = account.balance + amount
    account.update!(balance: new_balance)
  end
end
