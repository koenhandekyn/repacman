class PrintedsController < ApplicationController
  before_action :set_printed, only: %i[ show edit update destroy ]

  # GET /printeds
  def index
    @printeds = Printed.all
    @printeds = Printed.where(Batch: params[:batch]) if params[:batch].present?
  end

  def export
    @printeds = Printed.transaction do
      # Lock the rows with xml_exported_at as nil to prevent other transactions from updating them
      printeds = Printed.xml_exported_at_nil.lock(true)
      # Update the locked rows' xml_exported_at field to the current time
      Printed.where(id: printeds.map(&:id)).update_all(xml_exported_at: Time.now)
      # Return the locked rows
      printeds
    end
    respond_to do |format|
      format.xml {
        # force download
        send_data(render_to_string,
                  filename: "exact-natuly-labelling-#{Time.zone.now.to_date}.xml",
                  type: "application/xml",
                  disposition: "attachment")
      }
    end
  end

  # GET /printeds/1
  def show
  end

  # GET /printeds/new
  def new
    @printed = Printed.new
  end

  # GET /printeds/1/edit
  def edit
  end

  # POST /printeds
  def create
    @printed = Printed.new(printed_params)

    if @printed.save
      redirect_to @printed, notice: "Printed was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /printeds/1
  def update
    if @printed.update(printed_params)
      redirect_to @printed, notice: "Printed was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /printeds/1
  def destroy
    @printed.destroy!
    redirect_to printeds_url, notice: "Printed was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_printed
    @printed = Printed.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def printed_params
    params.require(:printed).permit(:itemCode, :Batch, :XMLExported)
  end
end
