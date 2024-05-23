class FamiliesController < ApplicationController
  before_action :set_family, only: %i[ show edit update destroy ]

  # GET /families
  def index
    @families = Family.all
  end

  # GET /families/1
  def show
  end

  # GET /families/new
  def new
    @family = Family.new
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families
  def create
    @family = Family.new(family_params)

    if @family.save
      redirect_to @family, notice: "Family was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /families/1
  def update
    if @family.update(family_params)
      redirect_to @family, notice: "Family was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /families/1
  def destroy
    @family.destroy!
    redirect_to families_url, notice: "Family was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def family_params
      params.require(:family).permit(:name, :composition, :components, :additives, :dosage, :claims, :instructions, :tht_months, :manufacturer_code)
    end
end
