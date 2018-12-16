class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :authenticate

  private

  def authenticate
    if !signed_in?
      redirect_to sign_in_url, warning: 'You need to sign in first'
    end
  end

end
