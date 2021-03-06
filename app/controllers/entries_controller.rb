class EntriesController < ApplicationController
  require_authentication! except: :create
  protect_from_forgery except: :create
  before_filter :verify_token, only: :create

  def create
    @member = Member.find_from_number!(params[:From])
    @entry = @member.entries.new(body: params[:Body])
    @entry.save
    respond_to(&:xml)
  end

  def index
    @entries_by_day = Entry.by_day
  end

  private

    def verify_token
      render nothing: true, status: :unauthorized if params[:token] != Switchboard.twilio_token
    end
end
