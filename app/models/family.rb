class Family < ApplicationRecord
  has_many :products
  has_many :assemblies, foreign_key: "parent_family_id", primary_key: "id"

  scope :bio, -> { where(bio: true) }
  scope :non_bio, -> { where(bio: false) }
end
