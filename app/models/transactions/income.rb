module Transactions
  class Income < Transaction
    belongs_to :destination_account, class_name: "Account", foreign_key: 'destination_account_id'

    validates :source_account, presence: true
  end
end
