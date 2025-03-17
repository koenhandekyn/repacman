class BatchOutputsController < ApplicationController
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

    if @batch_output.save
      # redirect_to @batch_output.batch, notice: "Batch output was successfully created."
      family = @batch_output.batch.family
      products = Product.includes(:family).where(family:)
      render turbo_stream: turbo_stream.append("batch_outputs", partial: "batches/batch_output_form", locals: { batch_output: @batch_output, products: }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_output.batch })
    else
      # TODO: render error message with turbo_stream
      # render :new, status: :unprocessable_entity
      # show error message
      family = @batch_output.batch.family
      products = Product.includes(:family).where(family:)
      render turbo_stream: turbo_stream.append("batch_outputs", partial: "batches/batch_output_form", locals: { batch_output: @batch_output, products: }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_output.batch })
    end
  end

  # PATCH/PUT /batch_outputs/1
  def update
    if @batch_output.update(batch_output_params)
      # redirect_to @batch_output.batch, notice: "Batch output was successfully updated.", status: :see_other
      family = @batch_output.batch.family
      products = Product.includes(:family).where(family:)
      render turbo_stream: turbo_stream.append("flashes", partial: "shared/flash", locals: { message: "Updated.", type: :notice }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_output.batch })
    else
      # render :edit, status: :unprocessable_entity
      # add some alert?
      family = @batch_output.batch.family
      products = Product.includes(:family).where(family:)
      render turbo_stream: turbo_stream.append("flashes", partial: "shared/flash", locals: { message: "Update failed.", type: :alert }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_output.batch })
    end
  end

  # DELETE /batch_outputs/1
  def destroy
    batch = @batch_output.batch
    @batch_output.destroy!
    render turbo_stream: turbo_stream.remove(@batch_output) +
                         turbo_stream.update("balances", partial: "batches/balances", locals: { batch: })
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
