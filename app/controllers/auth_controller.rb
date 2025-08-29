class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def callback
    user = User.find_or_create_from_google(auth_hash)
    if user.role.present?
      session[:user_id] = user.id
      redirect_to root_path
    else
      session[:user_id] = nil
      redirect_to home_login_path, alert: "User not authorized (missing role)"
    end
  end

  def failure
    redirect_to root_path, alert: "Authentication failed"
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
