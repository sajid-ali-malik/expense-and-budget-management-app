module Transactions
  class Transfer < Transaction
    belongs_to :source_account, class_name: "Account", foreign_key: 'source_account_id'
    belongs_to :destination_account, class_name: "Account", foreign_key: 'destination_account_id'

    validates :source_account, presence: true
    validates :destination_account, presence: true
     after_create :transfer_amount_between_accounts

    private

    def transfer_amount_between_accounts
      source_account.update(balance: source_account.balance - amount)
      destination_account.update(balance: destination_account.balance + amount)
    end
  end
end
