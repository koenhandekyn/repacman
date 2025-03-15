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
    @batch_output = BatchOutput.new(batch_output_params)

    if @batch_output.save
      redirect_to @batch_output, notice: "Batch output was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /batch_outputs/1
  def update
    if @batch_output.update(batch_output_params)
      redirect_to @batch_output.batch, notice: "Batch output was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /batch_outputs/1
  def destroy
    @batch_output.destroy!
    redirect_to batch_outputs_url, notice: "Batch output was successfully destroyed.", status: :see_other
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
