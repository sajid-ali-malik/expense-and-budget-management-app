FactoryBot.define do
  factory :user do
    name { 'Sajid Ali' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { '787898' }
  end
end
