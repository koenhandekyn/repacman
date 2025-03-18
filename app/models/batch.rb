# == Schema Information
#
# Table name: batches
#
#  id          :bigint           not null, primary key
#  produced_at :datetime         not null
#  batch_uid   :string(255)      default(""), not null
#  family_id   :integer          not null
#  weight      :decimal(10, )    default(1), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Batch < ApplicationRecord
  has_many :batch_inputs
  has_many :batch_outputs
  belongs_to :family

  validates :batch_uid, presence: true
  validates :batch_uid, uniqueness: true # validate batch uid is unique
  validates :produced_at, presence: true
  validates :weight, presence: true, numericality: { greater_than: 0 }

  def weight_in_kg
    Unit.new(weight).to("kg") rescue Unit.new("#{weight} kg").to("kg") rescue Unit.new("0 kg")
  end

  def weight_in_kg_f
    weight_in_kg.respond_to?(:scalar) ? weight_in_kg.scalar.to_f : weight_in_kg.to_f
  end

  def total_weight_inputs_in_kg
    batch_inputs.map(&:weight_in_kg).sum
  end

  def total_weight_inputs_in_kg_f
    total_weight_inputs_in_kg.respond_to?(:scalar) ? total_weight_inputs_in_kg.scalar.to_f : total_weight_inputs_in_kg.to_f
  end

  def total_weight_outputs_in_kg
    batch_outputs.map(&:weight_in_kg).sum
  end

  def total_weight_outputs_in_kg_f
    total_weight_outputs_in_kg.respond_to?(:scalar) ? total_weight_outputs_in_kg.scalar.to_f : total_weight_outputs_in_kg.to_f
  end

  def total_weight_difference_in_kg_io
    total_weight_outputs_in_kg_f - total_weight_inputs_in_kg_f
  end

  def total_weight_difference_in_kg_ib
    total_weight_inputs_in_kg_f - weight_in_kg_f
  end

  def total_weight_difference_in_kg_ob
    total_weight_outputs_in_kg_f - weight_in_kg_f
  end
end
