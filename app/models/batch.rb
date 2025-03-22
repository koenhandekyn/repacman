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

  def total_weight_inputs_base
    sum = batch_inputs.map(&:weight_base).sum
    sum == 0 ? Unit.new("0 kg") : sum
  rescue
    Unit.new("0 kg").to("kg")
  end

  def total_weight_outputs_base
    sum = batch_outputs.map(&:weight_base).sum
    sum == 0 ? Unit.new("0 kg") : sum
  rescue
    Unit.new("0 kg").to("kg")
  end

  def total_weight_difference_base_io
    total_weight_outputs_base - total_weight_inputs_base
  end

  def total_weight_difference_base_ib
    total_weight_inputs_base.scalar - weight_base.scalar
  end

  def total_weight_difference_base_ob
    total_weight_outputs_base.scalar - weight_base.scalar
  end
end
