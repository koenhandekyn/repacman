module TurboStreamBatchForms
  extend ActiveSupport::Concern
  include TurboStreamBase
  include TurboStreamBalances
  include TurboStreamFlashes

  # Helper method to get products for a family
  def products(family:)
    Product.includes(:family).where(family:)
  end
end
