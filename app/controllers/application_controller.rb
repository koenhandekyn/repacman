require "barby/barcode/code_128"
require "barby/outputter/html_outputter"

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_time_zone

  private

  def set_time_zone
    Time.zone = "Brussels" # Default time zone
  end

  def authenticate_user!
    unless current_user
      redirect_to "/home/login"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
