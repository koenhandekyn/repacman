class Batch < ApplicationRecord
  has_many :batch_products
  has_many :batch_packagings
  belongs_to :family
end
