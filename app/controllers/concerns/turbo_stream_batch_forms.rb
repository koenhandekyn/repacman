module TurboStreamBatchForms
  extend ActiveSupport::Concern
  include TurboStreamBase
  include TurboStreamBalances
  include TurboStreamFlashes

  # Helper method to get products for a family
  def products(family:)
    Product.includes(:family).where(family:)
  end

  # Renders a form stream with balances update
  def render_form_with_balances(container_id, batch, partial:, locals:, append: true)
    turbo_stream_actions(
      append_or_update_form(container_id, partial:, locals:, append:),
      update_balance(batch)
    )
  end
end
