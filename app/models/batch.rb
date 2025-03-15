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

  def total_weight_inputs
    batch_inputs.map(&:weight).sum
  end

  def total_weight_outputs
    batch_outputs.map(&:weight).sum
  end

  def total_weight_difference_io
    total_weight_inputs - total_weight_outputs
  end

  def total_weight_difference_ib
    total_weight_inputs - weight
  end

  def total_weight_difference_ob
    total_weight_outputs - weight
  end
end
