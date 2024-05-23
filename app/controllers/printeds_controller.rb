class PrintedsController < ApplicationController
  before_action :set_printed, only: %i[ show edit update destroy ]

  # GET /printeds
  def index
    @printeds = Printed.all
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
