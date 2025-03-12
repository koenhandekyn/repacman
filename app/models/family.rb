class Family < ApplicationRecord
  has_many :products
  has_many :assemblies, foreign_key: "parent_family_id", primary_key: "id"

  has_many :children, through: :assemblies, source: :child

  scope :bio, -> { where(bio: true) }
  scope :non_bio, -> { where(bio: false) }

  def total_assembly_weight
    assemblies.sum(:weight)
  end
end
