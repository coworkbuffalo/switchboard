class Entry < ActiveRecord::Base
  belongs_to :member

  ACTIONS = {
    'lock'   => /\A\s*lock/i,
    'unlock' => /\A\s*unlock/i
  }

  validates :action, inclusion: {in: ACTIONS}
  after_create :notify!

  def self.actions
    ACTIONS.keys
  end

  def self.by_day
    includes(:member).order(created_at: :desc).group_by do |entry|
      entry.created_at.in_time_zone("Eastern Time (US & Canada)").to_date
    end
  end

  def action
    attributes[:action] ||= ACTIONS.find { |_, regex| body =~ regex }.try :first
  end

  def unlock?
    action == 'unlock'
  end

  def lock?
    action == 'lock'
  end

  private

  def notify!
    Switchboard.twilio_client.account.messages.create(
      from: Switchboard.twilio_from_number,
      to:   Switchboard.twilio_to_number,
      body: "##{action}"
    )
  end
end
