class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token
  include SessionsHelper

  before_action :authenticate

  private

  def authenticate
    if !signed_in?
      redirect_to sign_in_url, warning: 'You need to sign in first'
    end
  end

  def errors(err)
    "<ul><li>#{err.full_messages.join('</li><li>')}</li></ul>"
  end


end
