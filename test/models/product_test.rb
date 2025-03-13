# == Schema Information
#
# Table name: products
#
#  id                   :bigint           not null, primary key
#  code                 :string(255)      not null
#  weight               :string(255)      default(""), not null
#  barcode              :string(255)
#  family_id            :integer          not null
#  label_id             :integer
#  plant_id             :integer          not null
#  bag_id               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  is_active            :boolean          default(TRUE)
#  print_label_repack   :boolean
#  label_background_url :string(255)
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
