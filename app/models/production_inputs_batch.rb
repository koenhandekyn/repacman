# == Schema Information
#
# Table name: production_inputs_batch
#
#  id                 :string(36)        not null, primary key, GUID Exact Online
#  ItemCode           :string(50)        not null, ItemCode Exact Online
#  batch_number       :string(100)       not null, BatchNumber Exact Online
#  available_quantity :decimal(20, 6)    Available quantity in Exact Online
#  UpdatedAt          :datetime          not null
#  warehouses         :json              JSON output warehouses Exact Online
#
class ProductionInputsBatch < ApplicationRecord
  self.table_name = "production_inputs_batch"
  # self.primary_key = "id"

  # validates :ItemCode, presence: true
  # validates :batch_number, presence: true
  # validates :available_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :product, foreign_key: "ItemCode", primary_key: "code"
end
