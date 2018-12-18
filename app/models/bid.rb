class Bid < ApplicationRecord
  belongs_to :slot
  belongs_to :organiser, class_name: 'User'

  validates :price, presence: true, numericality: true
  validate :new_bid_greater_than_highest_bid, if: :price

  def new_bid_greater_than_highest_bid
    return true if price > self.slot.highest_bid.try(:price).to_i
    errors.add(:price, "can't be less than or equal to current highest bid")
  end
end
