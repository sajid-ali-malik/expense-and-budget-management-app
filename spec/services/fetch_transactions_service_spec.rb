require 'rails_helper'

RSpec.describe FetchTransactionsService do
  subject { described_class.new(user, params).call }

  let!(:user) { create(:user, confirmed_at: Time.current) }
  let(:params) { { sort: 'asc', page: 1 } }

  describe '#call' do
    context 'when there are transactions' do
      let!(:account1) { create(:account, user:) }
      let!(:account2) { create(:account, user:) }
      let!(:category1) { create(:category) }
      let!(:category2) { create(:category) }

      let!(:expense_transaction) do
        create(:expense_transaction, user:, source_account: account1, created_at: 1.day.ago, category: category1)
      end
      let!(:income_transaction) do
        create(:income_transaction, user:, destination_account: account2, created_at: 2.days.ago)
      end
      let!(:transfer_transaction) do
        create(:transfer_transaction, user:, source_account: account1, destination_account: account2,
                                      created_at: 3.days.ago)
      end

      it 'returns transactions ordered by created_at ascending' do
        expect(subject).to eq([transfer_transaction, income_transaction, expense_transaction])
      end

      context 'when sort param is specified as desc' do
        let(:params) { { sort: 'desc', page: 1 } }

        it 'returns transactions ordered by created_at descending' do
          expect(subject).to eq([expense_transaction, income_transaction, transfer_transaction])
        end
      end

      context 'with filters' do
        context 'when filtering by source_account_id' do
          let(:params) { { source_account_id: account1.id } }

          it 'returns filtered transactions' do
            expect(subject).to contain_exactly(expense_transaction, transfer_transaction)
          end
        end

        context 'when filtering by destination_account_id' do
          let(:params) { { destination_account_id: account2.id } }

          it 'returns filtered transactions' do
            expect(subject).to contain_exactly(income_transaction, transfer_transaction)
          end
        end

        context 'when filtering by category_id' do
          let(:params) { { category_id: category1.id } }

          it 'returns filtered transactions' do
            expect(subject).to contain_exactly(expense_transaction)
          end
        end

        context 'when filtering by type' do
          let(:params) { { type: 'Transactions::Income' } }

          it 'returns filtered transactions' do
            expect(subject).to contain_exactly(income_transaction)
          end
        end
      end

      context 'when transfer transaction is also present' do
        let!(:transaction4) { create(:transfer_transaction, user:, created_at: 4.days.ago) }

        it 'includes transfer transactions in the result' do
          expect(subject).to include(transaction4)
        end
      end
    end

    context 'when there are no transactions' do
      it 'returns an empty result' do
        expect(subject).to be_empty
      end
    end
  end
end
