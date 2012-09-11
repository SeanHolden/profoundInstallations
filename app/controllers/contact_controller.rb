class ContactController < ApplicationController
  def index
  end

  def create
    @message = "Thanks, we have received your message. We aim to respond within 24 hours."
    redirect_to messagesent_path, notice: @message
  end
end
