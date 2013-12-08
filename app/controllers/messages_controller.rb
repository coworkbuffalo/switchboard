class MessagesController < ApplicationController
  require_authentication!

  def index
    @messages = Switchboard.twilio_client.account.messages.list
  end
end
