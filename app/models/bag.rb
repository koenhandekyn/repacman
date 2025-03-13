# == Schema Information
#
# Table name: bags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :string(255)
#
class Bag < ApplicationRecord
  has_many :products
end
