# Products created from a batch
class BatchPackaging < ApplicationRecord
  belongs_to :batch
  belongs_to :product
end
