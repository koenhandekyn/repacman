class Assembly < ApplicationRecord
  belongs_to :parent, class_name: 'Family', foreign_key: 'parent_family_id'
  belongs_to :child, class_name: 'Family', foreign_key: 'child_family_id'

  def name
    "#{child.name}"
  end

  alias :to_s :name
  alias :display_name :name
end
