class ContactController < ApplicationController

  def create
    name    = params[:Name]
    email   = params[:Email]
    message = params[:Message]
    if email.empty? || message.empty? || name.empty?
    	not_sent_msg = "Message not sent. Please fill in all fields."
      redirect_to contact_index_path, notice: not_sent_msg
    else
      UserMailer.contact_form_email(name, email, message).deliver
      confirmation_msg = "Thanks, we have received your message. We aim to respond within 24 hours."
      redirect_to messagesent_path, notice: confirmation_msg
    end
  end
end
