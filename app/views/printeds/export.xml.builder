# app/views/your_controller/index.xml.builder
xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.eExact('xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", 'xsi:noNamespaceSchemaLocation' => "eExact-XML.xsd") do
  xml.AssemblyOrders do
    @printeds.each do |item|
      xml.AssemblyOrder do
        xml.Warehouse(code: item.WarehouseCode)
        xml.Item(code: item.ItemCode)
        xml.PlannedQuantity item.PlannedQuantity
        xml.Description item.RepackDate
      end
    end
  end
end
