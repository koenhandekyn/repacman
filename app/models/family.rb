class Family < ApplicationRecord
  has_many :products

  scope :bio, -> { where(bio: true) }
  scope :non_bio, -> { where(bio: false) }
end
