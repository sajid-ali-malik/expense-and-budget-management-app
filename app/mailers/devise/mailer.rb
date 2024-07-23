class Devise::Mailer < ActionMailer::Base

  default template_path: 'devise/mailer'
  def confirmation_instructions(record, token, opts={})
    @token = token
    @resource = record

    mail(
      to: record.email,
      subject: 'Confirmation instructions'
    ) do |format|
      format.html { render 'devise/mailer/confirmation_instructions' }
      format.text { render plain: 'Confirmation instructions' }
    end
  end
end
