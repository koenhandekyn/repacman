# == Schema Information
#
# Table name: labels
#
#  id             :bigint           not null, primary key
#  nicelabel_name :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  printer_name   :string(255)
#
require "test_helper"

class LabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
