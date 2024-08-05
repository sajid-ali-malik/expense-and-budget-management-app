# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'expensemanagementapp'
  layout 'mailer'
end
