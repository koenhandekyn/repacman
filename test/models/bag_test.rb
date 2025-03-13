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
require "test_helper"

class BagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
