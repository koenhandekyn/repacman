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
require "test_helper"

class PrintedTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
