require "builder"

class Api::PrintedsController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  # include ActionController::MimeResponds

  before_action :authenticate_api_user!

  # GET /api/printeds
  def index
    @printeds = Printed.transaction do
      # Lock the rows with xml_exported_at as nil to prevent other transactions from updating them
      printeds = Printed.xml_exported_at_nil.lock(true)
      # Update the locked rows' xml_exported_at field to the current time
      Printed.where(id: printeds.map(&:id)).update_all(xml_exported_at: Time.now)
      # Return the locked rows
      printeds
    end
    @printeds = Printed.all.last(1)
    json_response = @printeds.map do |printed|
      {
        id: printed.id,
        download_url: api_printed_url(printed, format: :xml),
        item_code: printed.ItemCode,
        warehouse_code: printed.WarehouseCode,
        planned_quantity: printed.PlannedQuantity,
        repack_date: printed.RepackDate,
      }
    end

    render json: json_response
  end

  # GET /api/printeds/:id.xml
  def show
    @printed = Printed.find(params[:id])

    # Generate XML directly
    xml_content = generate_xml_for_printed(@printed)

    send_data(
      xml_content,
      filename: "printed-#{@printed.id}-#{@printed.Batch}.xml",
      type: "application/xml",
      disposition: "attachment",
    )
  end

  private

  def generate_xml_for_printed(printed)
    xml = Builder::XmlMarkup.new(indent: 2)
    xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
    xml.eExact("xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance", "xsi:noNamespaceSchemaLocation" => "eExact-XML.xsd") do
      xml.AssemblyOrders do
        xml.AssemblyOrder do
          xml.Warehouse(code: printed.WarehouseCode)
          xml.Item(code: printed.ItemCode)
          xml.PlannedQuantity printed.PlannedQuantity
          xml.Description printed.RepackDate
        end
      end
    end
    xml.target!
  end

  def authenticate_api_user!
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["API_USERNAME"] && password == ENV["API_PASSWORD"]
    end
  end
end
