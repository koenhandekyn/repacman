class PlantsController < ApplicationController
  before_action :set_plant, only: %i[ show edit update destroy ]

  # GET /plants
  def index
    @plants = Plant.all
  end

  # GET /plants/1
  def show
  end

  # GET /plants/new
  def new
    @plant = Plant.new
  end

  # GET /plants/1/edit
  def edit
  end

  # POST /plants
  def create
    @plant = Plant.new(plant_params)

    if @plant.save
      redirect_to @plant, notice: "Plant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /plants/1
  def update
    if @plant.update(plant_params)
      redirect_to @plant, notice: "Plant was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /plants/1
  def destroy
    @plant.destroy!
    redirect_to plants_url, notice: "Plant was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plant
      @plant = Plant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def plant_params
      params.require(:plant).permit(:streetnr, :zip, :city, :country)
    end
end
