class MessagesController < ApplicationController
  protect_from_forgery except: :create

  before_filter :verify_token

  def create
    @member = Member.find_from_number!(params[:From])
    @knock = Knock.new(params[:Body])
    respond_to(&:xml)
  end

  private

    def verify_token
      render nothing: true, status: :unauthorized if params[:token] != Switchboard.twilio_token
    end
end
