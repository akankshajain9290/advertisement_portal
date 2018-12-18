namespace :slots do
  desc 'Mark slots unavailable'

  task :mark_slots_unavailable => :environment do
    Slot.where(Slot.arel_table[:end_time].lteq(Time.now.utc)).update_all(status: :unavailable)
    Slot.pre_booked.where(Slot.arel_table[:start_time].lteq(Time.now.utc)).update_all(status: :unavailable)
    Slot.draft.where(Slot.arel_table[:start_time].lteq(Time.now.utc)).update_all(status: :unavailable)
  end
end
