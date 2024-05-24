class HomeController < ApplicationController
  def home
    @last_xml_exported_at = Printed.xml_exported_at_not_nil.maximum(:xml_exported_at)
    @export_count = Printed.xml_exported_at_nil.count
    @items = Printed.xml_exported_at_nil.pluck(:ItemCode)
  end
end
