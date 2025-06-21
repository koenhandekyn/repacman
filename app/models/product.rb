# == Schema Information
#
# Table name: products
#
#  id                   :bigint           not null, primary key
#  code                 :string(255)      not null
#  weight               :string(255)      default(""), not null
#  barcode              :string(255)
#  family_id            :integer          not null
#  label_id             :integer
#  plant_id             :integer          not null
#  bag_id               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  is_active            :boolean          default(TRUE)
#  print_label_repack   :boolean
#  label_background_url :string(255)
#
class Product < ApplicationRecord
  belongs_to :bag
  belongs_to :family
  belongs_to :label
  belongs_to :plant
  has_many :printeds, foreign_key: "Itemcode", primary_key: "code"

  scope :by_family, ->(family) { includes(:family).where(family: family) }
  scope :sorted_by_weight, -> { sort_by(&:weight_base_scalar).reverse }

  def name
    "#{family.name} (#{weight})"
  end

  def weight_base
    Unit.new(weight).to("kg") rescue Unit.new("#{weight} kg").to("kg") rescue Unit.new("0 kg")
  end

  def weight_base_scalar
    weight_base.scalar
  end

  alias :to_s :name
  alias :display_name :name
end
