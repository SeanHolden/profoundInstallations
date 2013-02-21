class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact_form_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(:to => '<email_address>', :subject => "New message from #{name}")
  end
end
