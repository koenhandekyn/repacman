module TurboStreamBalances
  extend ActiveSupport::Concern
  include TurboStreamBase

  # Returns a stream action to update the balances
  def update_balance(batch)
    turbo_stream.update("balances", partial: "batches/balances", locals: { batch: })
  end
end
