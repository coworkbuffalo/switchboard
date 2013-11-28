class Knock
  UNLOCK_TAG = "#unlock"
  LOCK_TAG   = "#lock"

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
end
