class Knock
  UNLOCK_TAG = "unlock"
  LOCK_TAG   = "lock"
  TOGGLE_TAG = "toggle"

  TAGS = [UNLOCK_TAG, LOCK_TAG, TOGGLE_TAG]

  def initialize(body)
    @body = body
  end

  def unlock?
    @body == UNLOCK_TAG
  end

  def lock?
    @body == LOCK_TAG
  end

  def toggle?
    @body == TOGGLE_TAG
  end

  def valid?
    unlock? || lock? || toggle?
  end

  def notify!
    Switchboard.twilio_client.account.messages.create(
      from: Switchboard.twilio_from_number,
      to:   Switchboard.twilio_to_number,
      body: "##{@body.gsub("#", "")}"
    )
  end
end
