module Transactions
  class Income < Transaction
    belongs_to :destination_account, class_name: "Account", foreign_key: 'destination_account_id'

    validates :destination_account, presence: true

    def account
      destination_account
    end
end
end
