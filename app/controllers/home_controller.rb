class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]

  def home
    @last_xml_exported_at = Printed.xml_exported_at_not_nil.maximum(:xml_exported_at)
    @export_count = Printed.xml_exported_at_nil.count
    @items = Printed.xml_exported_at_nil.pluck(:ItemCode)
  end

  def login
    if current_user
      redirect_to root_path, notice: "You are already logged in"
    else
      # flash[:notice] = "Click the button below to login with Google"
      render layout: "public"
    end
  end
end
