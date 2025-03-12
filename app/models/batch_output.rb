# Products created from a batch
class BatchOutput < ApplicationRecord
  belongs_to :batch
  belongs_to :product
end
