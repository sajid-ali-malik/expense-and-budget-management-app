module Transactions
  class Income < Transaction
    belongs_to :destination_account, class_name: "Account",foreign_key: 'destination_account_id'

    validates :destination_account, presence: true

    after_create :add_amount_to_account

    private

    def add_amount_to_account
      destination_account.update(balance: destination_account.balance + amount)
    end
  end
end
