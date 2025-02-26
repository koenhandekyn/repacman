# Products used to create a batch
class BatchProduct < ApplicationRecord
  belongs_to :batch
  belongs_to :product

  # def total_weight
  #   self.quantity * self.product.weight
  # end
end
