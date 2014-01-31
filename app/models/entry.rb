require 'rest-client'

class Entry < ActiveRecord::Base
  belongs_to :member

  ACTIONS = {
    'lock'   => /\A\s*l(ock)?/i,
    'unlock' => /\A\s*u(nlock)?/i
  }

  before_validation :extract_action
  validates :action, inclusion: {in: ACTIONS.keys}
  after_create :notify!

  def self.actions
    ACTIONS.keys
  end

  def self.by_day
    includes(:member).order(created_at: :desc).group_by do |entry|
      entry.created_at.in_time_zone("Eastern Time (US & Canada)").to_date
    end
  end

  def unlock?
    extract_action == 'unlock'
  end

  def lock?
    extract_action == 'lock'
  end

  private

  def extract_action
    self.action ||= ACTIONS.find { |_, regex| body =~ regex }.try :first
  end

  def notify!
    RestClient.post "http://#{ENV["DOOR_USER"]}:#{ENV["DOOR_TOKEN"]}@#{ENV["DOOR_URL"]}/api/device/CoworkBuffalo", switch: "on"
    sleep 1
    RestClient.post "http://#{ENV["DOOR_USER"]}:#{ENV["DOOR_TOKEN"]}@#{ENV["DOOR_URL"]}/api/device/CoworkBuffalo", switch: "off"
  end
end
