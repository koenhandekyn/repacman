class BatchInputsController < ApplicationController
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

    if @batch_input.save
      # redirect_to @batch_input.batch, notice: "Batch input was successfully created."
      family = @batch_input.batch.family.children
      products = Product.includes(:family).where(family:)
      render turbo_stream: turbo_stream.append("batch_inputs", partial: "batches/batch_input_form", locals: { batch_input: @batch_input, products: }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_input.batch })
    else
      # render :new, status: :unprocessable_entity
      # add some alert?
      family = @batch_input.batch.family.children
      products = Product.includes(:family).where(family:)
      render turbo_stream: turbo_stream.replace("new_batch_input", partial: "batches/batch_input_form", locals: { batch_input: @batch_input, products: }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_input.batch })
    end
  end

  # PATCH/PUT /batch_inputs/1
  def update
    if @batch_input.update(batch_input_params)
      # redirect_to @batch_input.batch, notice: "Batch input was successfully updated.", status: :see_other
      family = @batch_input.batch.family.children
      products = Product.includes(:family).where(family:)
      # render turbo_stream: turbo_stream.replace(@batch_input, partial: "batches/batch_input_form", locals: { batch_input: @batch_input, products: })
      # send a flash feedback message with turbo_stream, append it to the flash container
      render turbo_stream: turbo_stream.append("flashes", partial: "shared/flash", locals: { message: "Batch input was successfully updated." }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_input.batch })
    else
      # render :edit, status: :unprocessable_entity
      # add some alert?
      family = @batch_input.batch.family.children
      products = Product.includes(:family).where(family:)
      render turbo_stream: turbo_stream.replace(@batch_input, partial: "batches/batch_input_form", locals: { batch_input: @batch_input, products: }) +
                           turbo_stream.update("balances", partial: "batches/balances", locals: { batch: @batch_input.batch })
    end
  end

  # DELETE /batch_inputs/1
  def destroy
    batch = @batch_input.batch
    @batch_input.destroy!
    # redirect_to batch, notice: "Batch input was successfully destroyed.", status: :see_other
    render turbo_stream: turbo_stream.remove(@batch_input) +
                         turbo_stream.update("balances", partial: "batches/balances", locals: { batch: })
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
