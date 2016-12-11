class GlucoseMetersController < ApplicationController
  before_action :set_glucose_meter, only: [:show, :edit, :update, :destroy]

  # GET /glucose_meters
  # GET /glucose_meters.json
  def index
    @glucose_meters = GlucoseMeter.all
  end

  # GET /glucose_meters/1
  # GET /glucose_meters/1.json
  def show
  end

  # GET /glucose_meters/new
  def new
    @glucose_meter = GlucoseMeter.new
  end

  # GET /glucose_meters/1/edit
  def edit
  end

  # POST /glucose_meters
  # POST /glucose_meters.json
  def create
    @glucose_meter = GlucoseMeter.new(glucose_meter_params)

    respond_to do |format|
      if @glucose_meter.save
        format.html { redirect_to @glucose_meter, notice: 'Glucose meter was successfully created.' }
        format.json { render :show, status: :created, location: @glucose_meter }
      else
        format.html { render :new }
        format.json { render json: @glucose_meter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /glucose_meters/1
  # PATCH/PUT /glucose_meters/1.json
  def update
    respond_to do |format|
      if @glucose_meter.update(glucose_meter_params)
        format.html { redirect_to @glucose_meter, notice: 'Glucose meter was successfully updated.' }
        format.json { render :show, status: :ok, location: @glucose_meter }
      else
        format.html { render :edit }
        format.json { render json: @glucose_meter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /glucose_meters/1
  # DELETE /glucose_meters/1.json
  def destroy
    @glucose_meter.destroy
    respond_to do |format|
      format.html { redirect_to glucose_meters_url, notice: 'Glucose meter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_glucose_meter
      @glucose_meter = GlucoseMeter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def glucose_meter_params
      params.require(:glucose_meter).permit(:level, :references)
    end
end
