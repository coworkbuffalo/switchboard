module Switchboard
  def self.twilio_token
    if Rails.env.development? || Rails.env.test?
      "deadbeef"
    else
      ENV['TWILIO_TOKEN']
    end
  end

  def self.twilio_from_number
    if Rails.env.development? || Rails.env.test?
      "+15550001111"
    else
      ENV['TWILIO_FROM_NUMBER']
    end
  end

  def self.twilio_to_number
    if Rails.env.development? || Rails.env.test?
      "+15550002222"
    else
      ENV['TWILIO_TO_NUMBER']
    end
  end

  def self.twilio_client
    @twilio_client ||= Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'] || '', ENV['TWILIO_AUTH_TOKEN'] || ''
  end
end
