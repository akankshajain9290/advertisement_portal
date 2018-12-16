module Devise
  class RegistrationsController < ApplicationController
    skip_before_action :authenticate, only: [:new, :create]

    def create
      @user = User.new(sign_up_params)
      if @user.save
        sign_in @user
        flash.keep[:success] = 'Your account has been created successfully'
        redirect_to dashboard_url
      else
        flash[:danger] = "<ul><li>#{@user.errors.full_messages.join('</li><li>')}</li></ul>"
        render 'new'
      end

    end

    private

    def sign_up_params
      params.require(:user).permit(:username, :email, :password, :first_name, :last_name,
                                   :organisation, :role_id)
    end

  end
end
