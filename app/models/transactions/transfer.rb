module Transactions
  class Transfer < Transaction
    belongs_to :source_account, class_name: "Account",foreign_key: 'source_account_id'
    belongs_to :destination_account, class_name: "Account",foreign_key: 'destination_account_id'

    validates :source_account, presence: true
    validates :destination_account, presence: true
  end
end
