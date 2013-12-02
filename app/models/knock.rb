class Knock
  UNLOCK_TAG = "unlock"
  LOCK_TAG   = "lock"

  TAGS = [UNLOCK_TAG, LOCK_TAG]

  def initialize(body)
    @body = body
  end

  def unlock?
    @body == UNLOCK_TAG
  end

  def lock?
    @body == LOCK_TAG
  end

  def valid?
    unlock? || lock?
  end

  def notify!
    Switchboard.twilio_client.account.messages.create(
      from: Switchboard.twilio_from_number,
      to:   Switchboard.twilio_to_number,
      body: @body
    )
  end
end
