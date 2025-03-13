# == Schema Information
#
# Table name: families
#
#  id                :bigint           not null, primary key
#  name              :string(255)      not null
#  composition       :text(65535)
#  components        :text(65535)
#  additives         :text(65535)
#  dosage            :text(65535)
#  claims            :text(65535)
#  instructions      :text(65535)
#  tht_months        :integer
#  manufacturer_code :string(255)      default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bio               :boolean          default(TRUE)
#  is_batch          :boolean
#
require "test_helper"

class FamilyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
