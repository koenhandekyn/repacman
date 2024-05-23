class Printed < ApplicationRecord
  self.table_name = "Printed"

  belongs_to :product, foreign_key: "code", primary_key: "Itemcode"
end
