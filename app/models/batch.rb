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
  validates :weight, presence: true

  def weight_base
    # Unit.new(weight).to("kg") rescue Unit.new("#{weight} kg").to("kg") rescue Unit.new("0 kg")
    if Unit.new(weight).units.blank?
      Unit.new("#{weight} kg").to("kg")
    else
      Unit.new(weight).base
    end
  rescue
    Unit.new("0 kg").to("kg")
  end

  # def weight_base_f
  #   weight_base.respond_to?(:scalar) ? weight_base.scalar.to_f : weight_base.to_f
  # end

  def total_weight_inputs_base
    batch_inputs.map(&:weight_base).sum
  end

  # def total_weight_inputs_base_f
  #   total_weight_inputs_base.respond_to?(:scalar) ? total_weight_inputs_base.scalar.to_f : total_weight_inputs_base.to_f
  # end

  def total_weight_outputs_base
    batch_outputs.map(&:weight_base).sum
  end

  # def total_weight_outputs_base_f
  #   total_weight_outputs_base.respond_to?(:scalar) ? total_weight_outputs_base.scalar.to_f : total_weight_outputs_base.to_f
  # end

  def total_weight_difference_base_io
    total_weight_outputs_base - total_weight_inputs_base
  end

  def total_weight_difference_base_ib
    total_weight_inputs_base - weight_base
  end

  def total_weight_difference_base_ob
    total_weight_outputs_base - weight_base
  end
end
