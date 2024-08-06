require 'rails_helper'

RSpec.describe UpdateAccountBalance do
  let(:account1) { create(:account, balance: 1000) }
  let(:account2) { create(:account, balance: 2000) }

  describe '#call' do
    context 'when the transaction is a transfer' do
      let(:transaction) do
        create(:transfer_transaction, source_account: account1, destination_account: account2, amount: 100)
      end

      it 'updates the account balances' do
        described_class.new(transaction).call
        expect(account1.reload.balance).to eq(900)
        expect(account2.reload.balance).to eq(2100)
      end
    end

    context 'when the transaction is an income' do
      let(:transaction) { create(:income_transaction, destination_account: account2, amount: 200) }

      it 'updates the account balances' do
        described_class.new(transaction).call
        expect(account2.reload.balance).to eq(2200)
      end
    end

    context 'when the transaction is an expense' do
      let(:transaction) { create(:expense_transaction, source_account: account1, amount: 300) }

      it 'updates the account balances' do
        described_class.new(transaction).call
        expect(account1.reload.balance).to eq(700)
      end
    end
  end
end
