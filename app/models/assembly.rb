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
  belongs_to :parent, class_name: "Family", foreign_key: "parent_family_id"
  belongs_to :child, class_name: "Family", foreign_key: "child_family_id"

  def name
    "#{child.name}"
  end

  def storage
    "-"
  end

  def total_assembly_weight_base = parent.total_assembly_weight_base

  def fraction
    weight_base / total_assembly_weight_base
  rescue
    0
  end

  def target_weight(batch_weight)
    fraction_of_weight(batch_weight)
  end

  def fraction_of_weight(weight)
    self.fraction * weight
  end

  def target_quantity(batch_weight, product)
    product_weight = if product.weight_base.scalar == 0
        Unit.new("1 kg").to("kg").scalar.to_f
      else
        product.weight_base.scalar.to_f
      end

    target_weight(batch_weight).scalar.to_f / product_weight
    # rescue StandardError => e
    # raise "#{e.message} for #{product.inspect}"
  end

  # def fraction_of_weight_f(weight)
  #   fraction_of_weight(weight).respond_to?(:scalar) ? fraction_of_weight(weight).scalar.to_f : fraction_of_weight(weight).to_f
  # end

  def weight_base
    if Unit.new(weight).units.blank?
      Unit.new("#{weight} kg").to("kg")
    else
      Unit.new(weight).base
    end
  rescue
    Unit.new("0 kg").to("kg")
  end

  def weight_difference_in_batch(batch)
    actual_weight = batch.batch_inputs.joins(:product).where(products: { family: child }).sum(&:weight_base)
    expected_weight = fraction_of_weight(batch.weight_base)
    actual_weight - expected_weight
  rescue
    Unit.new("0 kg").to("kg")
  end

  def weight_difference_percentage_in_batch(batch)
    actual_weight = batch.batch_inputs.joins(:product).where(products: { family: child }).sum(&:weight_base)
    expected_weight = fraction_of_weight(batch.weight_base)
    (actual_weight - expected_weight) / expected_weight
  rescue
    nil
  end

  def weight_status_in_batch(batch)
    diff = weight_difference_in_batch(batch)
    diff_perc = weight_difference_percentage_in_batch(batch)
    if diff_perc > 0.01
      { status: :above, diff:, diff_perc: }
    elsif diff_perc < -0.01
      { status: :below, diff:, diff_perc: }
    else
      { status: :matching, diff:, diff_perc: }
    end
  end

  def step_major
    step.split(".").first rescue "?"
  end

  def step_minor
    step.split(".").last rescue "?"
  end

  alias :to_s :name
  alias :display_name :name
end
