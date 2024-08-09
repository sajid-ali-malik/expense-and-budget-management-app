FactoryBot.define do
  factory :budget do
    association :user
    association :category

    budget_month { Date.today.beginning_of_month }
    amount { 1000 }
  end
end
