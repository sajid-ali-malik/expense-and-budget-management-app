FactoryBot.define do
  factory :account do
    user
    name { 'Default Account' }
    balance { 999 }
    account_type { 'cash' }
  end
end
