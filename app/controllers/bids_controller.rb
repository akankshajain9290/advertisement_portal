class BidsController < ApplicationController

  def create
    bid = current_user.bids.build(bid_params)
    if bid.save
      flash.keep[:success] = 'Bid created successfully'
    else
      flash.keep[:danger] = errors(bid.errors)
    end
    redirect_to slots_url
  end

  private

  def bid_params
    params.require(:bid).permit(:slot_id, :price)
  end

end
