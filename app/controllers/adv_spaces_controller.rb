class AdvSpacesController < ApplicationController

  def create
    adv_space = current_user.adv_spaces.build(adv_space_params)
    if adv_space.save
      flash.keep[:success] = 'Adv Space created successfully'
    else
        flash.keep[:danger] = errors(adv_space.errors)
    end
    redirect_to dashboard_url
  end

  def update
    adv_space = AdvSpace.find(params[:id])
    if adv_space && adv_space.update_attributes(name: params[:adv_space][:name])
      flash.keep[:success] = 'Adv Space updated successfully'
    else
      flash.keep[:danger] = errors(adv_space.errors)
    end
    redirect_to dashboard_url
  end

  def destroy
    adv_space = AdvSpace.find(params[:id])

    if adv_space&.destroy
      flash.keep[:success] = 'Adv Space deleted successfully'
    else
      flash.keep[:danger] = errors(adv_space.errors)
    end

    redirect_to dashboard_url

  end

  private

  def adv_space_params
    params.require(:adv_space).permit(:name)
  end

end
