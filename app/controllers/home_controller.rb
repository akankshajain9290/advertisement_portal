class HomeController < ApplicationController
  layout 'home'

  def dashboard
    if current_user.agent?
      @slots = Slot.pre_booked_slots current_user.id
    elsif current_user.provider?
      @adv_spaces = current_user.adv_spaces
    elsif current_user.organiser?
      @slots = Slot.booked_available_slots current_user.id
    end

    render "#{current_user.role.label}_dashboard"
  end

end

