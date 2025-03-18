class BatchOutputsController < ApplicationController
  include TurboStreamBatchForms
  before_action :set_batch_output, only: %i[ show edit update destroy ]

  # GET /batch_outputs
  def index
    @batch_outputs = BatchOutput.all
  end

  # GET /batch_outputs/1
  def show
  end

  # GET /batch_outputs/new
  def new
    @batch_output = BatchOutput.new
  end

  # GET /batch_outputs/1/edit
  def edit
  end

  # POST /batch_outputs
  def create
    @batch = Batch.find(batch_output_params[:batch_id])
    @batch_output = BatchOutput.new(batch_output_params.merge(batch_uid: @batch.batch_uid))

    append = @batch_output.save

    locals = {
      batch_output: @batch_output,
      products: products(family: @batch_output.batch.family)
    }

    container_id = (append ? "batch_outputs" : "new_batch_output")

    turbo_stream_actions(
      append_or_update_form(container_id, partial: "batches/batch_output_form", locals:, append:),
      update_balance(@batch_output.batch)
    )
  end

  # PATCH/PUT /batch_outputs/1
  def update
    if @batch_output.update(batch_output_params)
      turbo_stream_actions(
        send_flash("Updated.", :notice),
        update_balance(@batch_output.batch)
      )
    else
      turbo_stream_actions(
        send_flash("Update failed.", :alert),
        update_balance(@batch_output.batch)
      )
    end
  end

  # DELETE /batch_outputs/1
  def destroy
    batch = @batch_output.batch
    @batch_output.destroy!
    turbo_stream_actions(
      turbo_stream.remove(@batch_output),
      update_balance(batch)
    )
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_batch_output
    @batch_output = BatchOutput.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def batch_output_params
    params.fetch(:batch_output, {}).permit(:batch_id, :product_id, :quantity, :batch_uid)
  end
end
