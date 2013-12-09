class Entry < ActiveRecord::Base
  belongs_to :member

  UNLOCK_TAG = "unlock"
  LOCK_TAG   = "lock"
  TAGS = [UNLOCK_TAG, LOCK_TAG]

  before_validation :format!
  validates :formatted_body, inclusion: {in: TAGS}
  after_create :notify!

  def self.by_day
    includes(:member).order(created_at: :desc).group_by do |entry|
      entry.created_at.in_time_zone("Eastern Time (US & Canada)").to_date
    end
  end

  def unlock?
    formatted_body == UNLOCK_TAG
  end

  def lock?
    formatted_body == LOCK_TAG
  end

  private

  def format!
    self.formatted_body = original_body.downcase.strip
  end

  def notify!
    Switchboard.twilio_client.account.messages.create(
      from: Switchboard.twilio_from_number,
      to:   Switchboard.twilio_to_number,
      body: "##{formatted_body.gsub("#", "")}"
    )
  end
end
