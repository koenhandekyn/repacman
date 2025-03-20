# == Schema Information
#
# Table name: batch_inputs
#
#  id         :bigint           not null, primary key
#  batch_id   :integer          not null
#  product_id :integer          not null
#  quantity   :integer          default(1), not null
#  batch_uid  :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BatchInput < ApplicationRecord
  belongs_to :batch
  belongs_to :product

  def weight_base
    self.quantity * self.product.weight_base
  end
end
