class Printed < ApplicationRecord
  self.table_name = "Printed"

  belongs_to :product, foreign_key: "code", primary_key: "Itemcode", optional: true

  scope :xml_exported_at_nil, -> { where(xml_exported_at: nil) }
  scope :xml_exported_at_not_nil, -> { where.not(xml_exported_at: nil) }
end
