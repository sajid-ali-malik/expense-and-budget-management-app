# frozen_string_literal: true

module Transactions
  class Transfer < Transaction
    belongs_to :source_account, class_name: 'Account', foreign_key: 'source_account_id'
    belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id'

    validate :check_for_distinct_accounts

    def account
      source_account
    end

    private

    def check_for_distinct_accounts
      return unless source_account_id == destination_account_id

      errors.add(:base, 'Source account and destination account must be different')
    end
  end
end
