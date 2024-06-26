module Transactions
  class Expense < Transaction
    belongs_to :source_account, class_name: "Account",foreign_key: 'source_account_id'

    validates :source_account, presence: true

    after_create :deduct_amount_from_account

    private

    def deduct_amount_from_account
      source_account.update(balance: source_account.balance - amount)
    end
  end
end
