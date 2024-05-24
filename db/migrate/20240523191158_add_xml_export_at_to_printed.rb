class AddXmlExportAtToPrinted < ActiveRecord::Migration[7.1]
  def change
    add_column :Printed, :xml_exported_at, :datetime, null: true
  end
end
