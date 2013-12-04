class MessagesController < ApplicationController
  protect_from_forgery except: :create

  before_filter :verify_token, only: :create

  def create
    @member = Member.find_from_number!(params[:From])
    @knock = Knock.new(params[:Body])
    @knock.notify! if @knock.valid?
    respond_to(&:xml)
  end

  def index
    @messages = Switchboard.twilio_client.account.messages.list
  end

  private

    def verify_token
      render nothing: true, status: :unauthorized if params[:token] != Switchboard.twilio_token
    end
end
