class SlotsController < ApplicationController
  layout 'home'

  def index
    @slots = available_slots
  end

  def create
    slot = current_user.slots.build(create_slot_params)

    if slot.save
      flash.keep[:success] = 'Slot created successfully'
    else
      flash.keep[:danger] = errors(slot.errors)
    end
    redirect_to slots_url
  end

  def update
    if slot.update(update_slot_params)
      flash.keep[:success] = 'Slot updated successfully'
      redirect_to slots_url if current_user.role.provider?
      redirect_to dashboard_url if current_user.role.agent?
    else
      flash.keep[:danger] = errors(slot.errors)
      redirect_to slots_url
    end

  end

  def destroy
    if slot.destroy
      flash.keep[:success] = 'Slot deleted successfully'
    else
      flash.keep[:danger] = errors(slot.errors)
    end
    redirect_to slots_url
  end

  private

  def update_slot_params
    send("#{current_user.role.label}_updateable_slot_params")
  end

  def create_slot_params
    params.require(:slot).permit(:name, :start_time, :end_time, :price, :adv_space_id)
  end

  def agent_updateable_slot_params
    {
      status: (slot.pre_booked? ? Slot.statuses[:booked] : Slot.statuses[:pre_booked]),
      agent_id: (slot.draft? ? current_user.id : slot.agent_id),
      organiser_id: (slot.pre_booked? ? slot.highest_bid.organiser.id : slot.agent_id)
    }
  end

  def provider_updateable_slot_params
    {
      price: params[:slot]&.[](:price) || slot.price,
      start_time: params[:slot]&.[](:start_time) || slot.start_time,
      end_time: params[:slot]&.[](:end_time) || slot.end_time
    }
  end

  def slot
    @slot ||= Slot.find(params[:id])
  end

  def available_slots
    send("#{current_user.role.label}_available_slots")
  end

  def agent_available_slots
    Slot.draft_available_slots
  end

  def organiser_available_slots
    Slot.pre_booked_available_slots
  end

  def provider_available_slots
    current_user.slots.order(:adv_space_id, :start_time)
  end

end
