class BatchInputsController < ApplicationController
  include TurboStreamBatchForms
  before_action :set_batch_input, only: %i[ show edit update destroy ]

  # GET /batch_inputs
  def index
    @batch_inputs = BatchInput.all
  end

  # GET /batch_inputs/1
  def show
  end

  # GET /batch_inputs/new
  def new
    @batch_input = BatchInput.new
  end

  # GET /batch_inputs/1/edit
  def edit
  end

  # POST /batch_inputs
  def create
    @batch_input = BatchInput.new(batch_input_params)

    append = @batch_input.save

    locals = {
      batch_input: @batch_input,
      products: products(family: @batch_input.batch.family)
    }

    render_form_with_balances(
      (append ? "batch_inputs" : "new_batch_input"),
      @batch_input.batch,
      partial: "batches/batch_input_form",
      locals:,
      append:
    )
  end

  # PATCH/PUT /batch_inputs/1
  def update
    if @batch_input.update(batch_input_params)
      turbo_stream_actions(
        send_flash("Updated.", :notice),
        update_balance(@batch_input.batch)
      )
    else
      turbo_stream_actions(
        send_flash("Update failed.", :alert),
        update_balance(@batch_input.batch)
      )
    end
  end

  # DELETE /batch_inputs/1
  def destroy
    batch = @batch_input.batch
    @batch_input.destroy!
    turbo_stream_actions(
      turbo_stream.remove(@batch_input),
      update_balance(batch)
    )
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_batch_input
    @batch_input = BatchInput.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def batch_input_params
    params.fetch(:batch_input, {}).permit(:batch_id, :product_id, :quantity, :batch_uid)
  end
end
