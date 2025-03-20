# == Schema Information
#
# Table name: families
#
#  id                :bigint           not null, primary key
#  name              :string(255)      not null
#  composition       :text(65535)
#  components        :text(65535)
#  additives         :text(65535)
#  dosage            :text(65535)
#  claims            :text(65535)
#  instructions      :text(65535)
#  tht_months        :integer
#  manufacturer_code :string(255)      default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bio               :boolean          default(TRUE)
#  is_batch          :boolean
#
class Family < ApplicationRecord
  has_many :products
  has_many :assemblies, foreign_key: "parent_family_id", primary_key: "id"

  has_many :children, through: :assemblies, source: :child

  scope :bio, -> { where(bio: true) }
  scope :non_bio, -> { where(bio: false) }

  def total_assembly_weight_base
    assemblies.map(&:weight_base).sum rescue Unit.new("0 kg")
  end

  def total_assembly_weight_base_f
    if total_assembly_weight_base.respond_to? :scalar
      total_assembly_weight_base.scalar.to_f
    else
      total_assembly_weight_base.to_f
    end
  end
end
