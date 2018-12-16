class HomeController < ApplicationController
  layout 'home'

  def dashboard
    if current_user.agent?
      @slots = current_user.pre_booked_slots.not_started
    elsif current_user.provider?
      @adv_spaces = current_user.adv_spaces
    elsif current_user.organiser?
      @slots = current_user.booked_slots.not_ended
    end

    render "#{current_user.role.label}_dashboard"
  end

end

