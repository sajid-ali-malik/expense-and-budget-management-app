FactoryBot.define do
  factory :transaction, class: 'Transaction' do
    amount { 10 }
    user

    factory :expense_transaction, class: 'Transactions::Expense' do
      type { 'Transactions::Expense' }
      source_account { create(:account) }
      category { create(:category) }
    end

    factory :income_transaction, class: 'Transactions::Income' do
      type { 'Transactions::Income' }
      destination_account { create(:account) }
    end

    factory :transfer_transaction, class: 'Transactions::Transfer' do
      type { 'Transactions::Transfer' }
      source_account { create(:account) }
      destination_account { create(:account) }
    end
  end
end
