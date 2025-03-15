require 'barby/barcode/code_128'
require 'barby/outputter/html_outputter'

class ApplicationController < ActionController::Base
  before_action :authenticate
  before_action :set_time_zone

  private

  def set_time_zone
    Time.zone = 'Brussels' # Default time zone
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['MOTOR_AUTH_USERNAME'] && password == ENV['MOTOR_AUTH_PASSWORD']
    end
  end
end
