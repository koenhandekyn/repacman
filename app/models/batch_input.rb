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
    return Unit.new("0 kg") if quantity.nil? || product.nil?
    quantity * product.weight_base
  end

  # return the assembly for the product in the batch
  def assembly
    return nil unless batch&.family && product&.family

    Assembly.find_by(
      parent_family_id: batch.family.id,
      child_family_id: product.family.id,
    )
  end
end
