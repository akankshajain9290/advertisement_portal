module SessionsHelper
  # create session for a logged in user
  def sign_in (user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
