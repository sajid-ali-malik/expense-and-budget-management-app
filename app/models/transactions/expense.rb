module Transactions
  class Expense < Transaction
    belongs_to :source_account, class_name: "Account",foreign_key: 'source_account_id'
    validates :source_account, presence: true
  end
end
