class AssembliesController < ApplicationController
  before_action :set_assembly, only: %i[ show edit update destroy ]

  # GET /assemblies
  def index
    @assemblies = Assembly.all
  end

  # GET /assemblies/1
  def show
  end

  # GET /assemblies/new
  def new
    @assembly = Assembly.new
  end

  # GET /assemblies/1/edit
  def edit
  end

  # POST /assemblies
  def create
    @assembly = Assembly.new(assembly_params)

    if @assembly.save
      redirect_to @assembly, notice: "Assembly was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assemblies/1
  def update
    if @assembly.update(assembly_params)
      redirect_to @assembly, notice: "Assembly was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /assemblies/1
  def destroy
    @assembly.destroy!
    redirect_to assemblies_url, notice: "Assembly was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assembly
      @assembly = Assembly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assembly_params
      params.fetch(:assembly, {})
    end
end
