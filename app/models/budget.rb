class Budget < ApplicationRecord
  belongs_to :user

  enum category: {
    groceries: 'groceries',
    rent: 'rent',
    utilities: 'utilities',
    entertainment: 'entertainment',
    travel: 'travel',
    other: 'other'
  }

  enum period: {
    weekly: 'weekly',
    monthly: 'monthly',
    yearly: 'yearly'
  }


  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :user_id, :name, :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
