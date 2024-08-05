require 'rails_helper'

RSpec.describe RevertAccountBalance do
  describe '#call' do
    subject { described_class.new(transaction).call }

    context 'when the transaction is a transfer' do
      let(:transaction) { create(:transfer_transaction) }

      it 'reverts the account balances' do
        expect { subject }.to change { transaction.source_account.reload.balance }.by(transaction.amount)
                                                                                  .and change {
                                                                                         transaction.destination_account.reload.balance
                                                                                       }.by(-transaction.amount)
      end
    end

    context 'when the transaction is an income' do
      let(:transaction) { create(:income_transaction) }

      it 'reverts the account balance' do
        expect { subject }.to change { transaction.destination_account.reload.balance }.by(-transaction.amount)
      end
    end

    context 'when the transaction is an expense' do
      let(:transaction) { create(:expense_transaction) }

      it 'reverts the account balance' do
        expect { subject }.to change { transaction.source_account.reload.balance }.by(transaction.amount)
      end
    end
  end
end
