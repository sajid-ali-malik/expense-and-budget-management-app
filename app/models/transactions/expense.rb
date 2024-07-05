module Transactions
  class Expense < Transaction
    belongs_to :source_account, class_name: "Account", foreign_key: 'source_account_id'
    belongs_to :category, class_name: "Category", foreign_key: 'category_id'

    def account
      source_account
    end
  end
end
