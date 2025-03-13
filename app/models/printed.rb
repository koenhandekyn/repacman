# == Schema Information
#
# Table name: Printed
#
#  id                 :integer          not null, primary key
#  NicelabelId        :string(12)
#  RepackDate         :string(255)
#  ItemCode           :string(255)      not null
#  WarehouseCode      :integer          not null
#  PlannedQuantity    :integer          not null
#  ProductDescription :text(65535)
#  Weight             :string(255)
#  Batch              :string(255)
#  MotherBatch        :string(255)
#  XMLExported        :boolean          default(FALSE), not null
#  CreatedAt          :datetime         not null
#  UpdatedAt          :datetime         not null
#  xml_exported_at    :datetime
#  Best_Before_Date   :date
#
class Printed < ApplicationRecord
  self.table_name = "Printed"

  belongs_to :product, foreign_key: "code", primary_key: "Itemcode", optional: true

  scope :xml_exported_at_nil, -> { where(xml_exported_at: nil) }
  scope :xml_exported_at_not_nil, -> { where.not(xml_exported_at: nil) }
end
