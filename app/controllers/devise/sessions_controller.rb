module Devise
  class SessionsController < ApplicationController
    skip_before_action :authenticate, only: [:new, :create]

    def create
      user = User.find_by_email_or_username(params[:session][:username])
      if user&.authenticate(params[:session][:password])
        sign_in user
        flash.keep[:success] = 'You have been signed in successfully'
        redirect_to dashboard_url
      else
        flash[:danger] = 'Username or password is incorrect.'
        render 'new'
      end
    end

    def destroy
      sign_out
      flash.keep[:success] =  'You have been signed out successfully'
      redirect_to sign_in_url
    end

  end
end
