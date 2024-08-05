class UserMailer < ApplicationMailer
  default from: 'expensemanagementapp'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Expense Management App')
  end
end
