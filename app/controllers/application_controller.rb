class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def self.require_authentication!(options = {})
    http_basic_authenticate_with options.merge(name: "coworkbuffalo", password: Switchboard.admin_password)
  end
end
