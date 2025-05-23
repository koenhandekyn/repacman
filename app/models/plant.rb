# == Schema Information
#
# Table name: plants
#
#  id         :bigint           not null, primary key
#  streetnr   :string(255)      default(""), not null
#  zip        :string(255)      default(""), not null
#  city       :string(255)      default(""), not null
#  country    :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  email      :string(255)      default("")
#
class Plant < ApplicationRecord
  has_many :products
end
