class RubyUnits::Unit
  include ActionView::Helpers::NumberHelper
  def to_s(precision: 3, delimiter: ' ')
    "#{number_with_precision(self.base.scalar, precision:, delimiter:)} #{self.base.units}"
  end
end
