class Product < ApplicationRecord
  belongs_to :bag
  belongs_to :family
  belongs_to :label
  belongs_to :plant
end
