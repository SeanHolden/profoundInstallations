class UserMailer < ActionMailer::Base
  default from: "Profound Installations"

  def contact_form_email(name, email, message)
    @name    = name
    @email   = email
    @message = message
    mail(:to => APP_CONFIG[Rails.env]['email_address_to'], :subject => "New message from #{name}")
  end
end
