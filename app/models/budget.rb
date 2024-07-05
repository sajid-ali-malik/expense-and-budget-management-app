class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum period: {
    January: 'January',
    February: 'February',
    March: 'March',
    April: 'April',
    May: 'May',
    June: 'June',
    July: 'July',
    August: 'August',
    September: 'September',
    October: 'October',
    November: 'November',
    December: 'December'
  }


  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :user_id, :name, :period, :category_id, presence: true

end
