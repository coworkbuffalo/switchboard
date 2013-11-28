module Switchboard
  def self.twilio_token
    if Rails.env.development? || Rails.env.test?
      "deadbeef"
    else
      ENV['TWILIO_TOKEN']
    end
  end
end
