class BagsController < ApplicationController
  before_action :set_bag, only: %i[ show edit update destroy ]

  # GET /bags
  def index
    @bags = Bag.all
  end

  # GET /bags/1
  def show
  end

  # GET /bags/new
  def new
    @bag = Bag.new
  end

  # GET /bags/1/edit
  def edit
  end

  # POST /bags
  def create
    @bag = Bag.new(bag_params)

    if @bag.save
      redirect_to @bag, notice: "Bag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bags/1
  def update
    if @bag.update(bag_params)
      redirect_to @bag, notice: "Bag was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bags/1
  def destroy
    @bag.destroy!
    redirect_to bags_url, notice: "Bag was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bag
      @bag = Bag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bag_params
      params.require(:bag).permit(:name)
    end
end
