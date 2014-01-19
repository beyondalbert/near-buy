class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:user]) if cookies[:user]
  end

  def login_as(user, remember_me)
    if remember_me
      cookies[:user] = {value: user.auth_token, expires: 2.weeks.from_now}
    else
      cookies[:user] = user.auth_token
    end
    @current_user = user
  end
end
