module ByCategoryAndMonth
  extend ActiveSupport::Concern

  included do
    scope :by_category_and_month, lambda { |user, category_id, budget_month|
      where(user:)
        .where(category_id:)
        .where(created_at: budget_month.beginning_of_month..budget_month.end_of_month)
    }
  end
end
