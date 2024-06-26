class LabelsController < ApplicationController
  before_action :set_label, only: %i[ show edit update destroy ]

  # GET /labels
  def index
    @labels = Label.all
  end

  # GET /labels/1
  def show
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1/edit
  def edit
  end

  # POST /labels
  def create
    @label = Label.new(label_params)

    if @label.save
      redirect_to @label, notice: "Label was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /labels/1
  def update
    if @label.update(label_params)
      redirect_to @label, notice: "Label was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /labels/1
  def destroy
    @label.destroy!
    redirect_to labels_url, notice: "Label was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def label_params
      params.require(:label).permit(:nicelabel_name)
    end
end
