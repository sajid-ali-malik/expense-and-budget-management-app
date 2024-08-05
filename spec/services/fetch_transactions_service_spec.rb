require 'rails_helper'

RSpec.describe FetchTransactionsService do
  let(:user) { create(:user) }
  let(:params) { { sort: 'asc', page: 1 } }

  describe '#call' do
    subject { described_class.new(user, params).call }

    context 'when there are transactions' do
      let!(:transaction1) { create(:expense_transaction, user:, created_at: 1.day.ago) }
      let!(:transaction2) { create(:income_transaction, user:, created_at: 2.days.ago) }

      it 'returns transactions ordered by created_at ascending' do
        expect(subject).to eq([transaction2, transaction1])
      end

      context 'with filters' do
        let(:params) { { source_account_id: transaction1.source_account_id } }

        it 'returns filtered transactions' do
          expect(subject).to eq([transaction1])
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
