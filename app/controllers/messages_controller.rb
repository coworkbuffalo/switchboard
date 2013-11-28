class MessagesController < ApplicationController
  protect_from_forgery except: :create

  def create
    respond_to(&:xml)
  end
end
