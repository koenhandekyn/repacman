class Product < ApplicationRecord
  belongs_to :bag
  belongs_to :family
  belongs_to :label
  belongs_to :plant
  has_many :printeds, foreign_key: "Itemcode", primary_key: "code"

  def name
    "#{family.name} (#{weight})"
  end

  alias :to_s :name
  alias :display_name :name
end
