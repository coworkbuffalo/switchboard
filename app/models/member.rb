class Member < ActiveRecord::Base
  has_many :entries

  phony_normalize :phone_number, default_country_code: 'US'
  validates :phone_number, phony_plausible: true, presence: true
  validates :name, presence: true

  def self.find_from_number!(number)
    find_by_phone_number! PhonyRails.normalize_number(number)
  end
end
