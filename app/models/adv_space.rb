class AdvSpace < ApplicationRecord
  belongs_to :provider, class_name: 'User'
  has_many :slots

  validates :name, presence: true

  before_destroy do
    cannot_delete_if_having_pre_booked_or_booked_slots
    throw(:abort) if errors.present?
  end

  def slot_exist_for_given_time?(start_time, end_time, slot_id)
    self.slots.where.not(id: slot_id)
              .where('(end_time > ? and end_time <= ?) or (start_time >= ? and start_time < ?)',
                start_time, end_time, start_time, end_time).exists?
  end

  def cannot_delete_if_having_pre_booked_or_booked_slots
    errors.add(:base, 'Cannot delete adv space having booked or pre_booked slots') if slots.booked.present? || slots.pre_booked.present?
  end

end
