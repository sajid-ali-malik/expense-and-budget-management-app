module Transactions
  class Expense < Transaction
<<<<<<< Updated upstream
    belongs_to :source_account, class_name: "Account",foreign_key: 'source_account_id'

    validates :source_account, presence: true
=======
    belongs_to :source_account, class_name: "Account", foreign_key: 'source_account_id'
    belongs_to :category, class_name: "Category", foreign_key: 'category_id'

    def account
      source_account
    end
>>>>>>> Stashed changes
  end
end
