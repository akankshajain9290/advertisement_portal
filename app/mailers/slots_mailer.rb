class SlotsMailer < ApplicationMailer
  default from: 'from@example.com'

  def slot_booked_for_agent(slot)
    @slot = slot
    mail(to: @slot.agent.email, subject: "Slot has been booked for space #{@slot.adv_space.name}")
  end

  def slot_booked_for_organiser(slot)
    @slot = slot
    mail(to: @slot.organiser.email, subject: "Slot has been booked for space #{@slot.adv_space.name}")
  end

  def slot_pre_booked_for_agent(slot)
    @slot = slot
    mail(to: @slot.agent.email, subject: "Slot has been prebooked for space #{@slot.adv_space.name}")
  end

  def slot_pre_booked_for_provider(slot)
    @slot = slot
    mail(to: @slot.adv_space.provider.email, subject: "Slot has been prebooked for space #{@slot.adv_space.name}")
  end
end
