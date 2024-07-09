# frozen_string_literal: true

module Transactions
  class Income < Transaction
    belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id', optional: true

    validates :destination_account_id, presence: true

    def account
      destination_account
    end
  end
end
