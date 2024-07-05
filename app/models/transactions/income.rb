module Transactions
  class Income < Transaction
<<<<<<< Updated upstream
    belongs_to :source_account, class_name: "Account",foreign_key: 'source_account_id'
=======
    belongs_to :destination_account, class_name: "Account", foreign_key: 'destination_account_id'
>>>>>>> Stashed changes

    validates :source_account, presence: true
  end
end
