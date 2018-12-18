class Slot < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :adv_space
  belongs_to :agent, class_name: 'User', optional: true
  belongs_to :organiser, class_name: 'User', optional: true
  has_many :bids

  before_save :initialize_status

  before_destroy do
    cannot_delete_pre_booked_or_booked_slots
    throw(:abort) if errors.present?
  end

  enum status: {
    draft: 'draft',
    pre_booked: 'pre_booked',
    booked: 'booked',
    unavailable: 'unavailable'
  }

  DATE_TIME_FORMAT = '%Y-%d-%m %H:%M:%S'

  scope :not_started, -> { where(arel_table[:start_time].gteq(Time.now.utc)) }
  scope :not_ended, -> { where(arel_table[:end_time].gteq(Time.now.utc)) }
  scope :ended, -> { where(arel_table[:end_time].lteq(Time.now.utc)) }
  scope :pre_booked_or_booked, -> (adv_space_id){ where('adv_space_id = ? and (status = ? or status = ?) and end_time > ?', adv_space_id,:pre_booked, :booked, Time.now.utc) }

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :price, presence: true
  validate :start_time_should_be_less_than_end_time
  validate :unique_slot_duration
  validate :slot_updatable?

  def highest_bid
    self.bids.order(price: :desc).first
  end

  def formatted_start_time
    start_time.strftime(DATE_TIME_FORMAT)
  end

  def formatted_end_time
    end_time.strftime(DATE_TIME_FORMAT)
  end

  def initialize_status
    self.status ||= :draft
  end

  def start_time_should_be_less_than_end_time
    return if !start_time || !end_time
    return true if !(start_time >= end_time)
    errors.add(:start_time, "can't be greater than or equal to end_time")
  end

  def unique_slot_duration
    return true if !slot_exist_for_given_time?
    errors.add('slot_duration', 'Given slot duration overlaps with existing slots')
  end

  def slot_updatable?
    return true if status_changed? || (!pre_booked? && !booked?)
    errors.add(:base, 'Cannot update booked or pre_booked slots')
  end

  def self.pre_booked_slots(agent_id)
    where(status: [:pre_booked, :booked], agent_id: agent_id)
  end

  def self.booked_available_slots(organiser_id)
    booked.not_ended.where(organiser_id: organiser_id)
  end

  def self.pre_booked_available_slots
    pre_booked.not_ended
  end

  def self.draft_available_slots
    draft.not_started
  end

  private

  def slot_exist_for_given_time?
    self.adv_space.slot_exist_for_given_time?(self.start_time, self.end_time, self.id)
  end

  def cannot_delete_pre_booked_or_booked_slots
    errors.add(:base, 'Cannot delete booked or pre_booked slots') if booked? || pre_booked?
  end

end
