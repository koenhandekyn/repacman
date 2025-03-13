# == Schema Information
#
# Table name: assemblies
#
#  id               :bigint           not null, primary key
#  parent_family_id :integer          not null
#  child_family_id  :integer          not null
#  weight           :decimal(10, 2)   default(1.0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Assembly < ApplicationRecord
  belongs_to :parent, class_name: 'Family', foreign_key: 'parent_family_id'
  belongs_to :child, class_name: 'Family', foreign_key: 'child_family_id'

  def name
    "#{child.name}"
  end

  def fraction
    ((weight / parent.total_assembly_weight) * 100).round(2)
  end

  alias :to_s :name
  alias :display_name :name
end
