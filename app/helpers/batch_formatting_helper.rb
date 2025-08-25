# frozen_string_literal: true

module BatchFormattingHelper
  include ActionView::Helpers::NumberHelper

  def format_fraction(assembly)
    number_to_percentage(assembly.fraction.scalar.to_f * 100, precision: 2, strip_insignificant_zeros: true)
  end

  def format_weight_with_units(unit, precision: 3)
    abs = number_with_precision(unit.scalar.abs, precision:, strip_insignificant_zeros: true)
    with_sign = unit.scalar.negative? ? "- #{abs}" : abs
    "#{with_sign} #{unit.units}"
  end

  def format_weight_with_units_with_sign(unit, precision: 3)
    abs = number_with_precision(unit.scalar.abs, precision:, strip_insignificant_zeros: true)
    with_sign = unit.scalar.negative? ? "- #{abs}" : "+ #{abs}"
    "#{with_sign} #{unit.units}"
  end
end
