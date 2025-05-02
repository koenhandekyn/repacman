class BatchesController < ApplicationController
  before_action :set_batch, only: %i[ show edit update destroy ]

  # GET /batches
  def index
    @batches = Batch.all
  end

  # GET /batches/1
  def show
  end

  # GET /batches/new
  def new
    @batch = Batch.new(
      produced_at: Time.zone.now,
      batch_uid: Time.zone.now.strftime("P%y%m%d") + Time.zone.now.seconds_since_midnight.to_i.to_s.rjust(5, '0')
    )
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches
  def create
    @batch = Batch.new(batch_params)

    if @batch.save
      redirect_to [:edit, @batch], notice: "Batch was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /batches/1
  def update
    if @batch.update(batch_params)
      redirect_to @batch, notice: "Batch was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /batches/1
  def destroy
    @batch.destroy!
    redirect_to batches_url, notice: "Batch was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.fetch(:batch, { }).permit(:produced_at, :batch_uid, :family_id, :weight, :best_before_date)
    end
end

#  id          :bigint           not null, primary key
#  produced_at :datetime         not null
#  batch_uid   :string(255)      default(""), not null
#  family_id   :integer          not null
#  weight      :decimal(10, )    default(1), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
