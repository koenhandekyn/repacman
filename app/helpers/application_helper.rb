module ApplicationHelper
  def available_batch_uids_for_product(product)
    product.production_inputs_batch
           .distinct
           .pluck(:batch_number)
           .compact
           .reject(&:blank?)
           .sort
  end
end
