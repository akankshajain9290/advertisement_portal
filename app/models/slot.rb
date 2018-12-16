class Slot < ApplicationRecord
  belongs_to :adv_space
  belongs_to :provider, class_name: 'User'
  belongs_to :agent, class_name: 'User', optional: true
  belongs_to :organiser, class_name: 'User', optional: true
  has_many :bids

  enum status: {
    draft: 'draft',
    pre_booked: 'pre_booked',
    booked: 'booked',
    unavailable: 'unavailable'
  }

  scope :not_started, -> { where('start_time >= ?', Time.now) }
  scope :not_ended, -> { where('end_time >= ?', Time.now) }
  scope :ended, -> { where('end_time <= ?', Time.now) }

  def highest_bid
    self.bids.pluck(:price).max
  end
end
