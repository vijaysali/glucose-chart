class GlucoseMetersController < ApplicationController
  before_action :set_user, only: [:todays, :last_month, :custom_range, :display_custom_range]

  def todays
    @data = @user.todays_report
  end

  def last_month
    @data = @user.last_month_report
  end

  def custom_range

  end

  def display_custom_range
    start_date_params = params[:range]["st(1i)"] + "-" + params[:range]["st(2i)"] + "-" + params[:range]["st(3i)"] + " 00:00:00"
    end_date_params   = params[:range]["ed(1i)"] + "-" + params[:range]["ed(2i)"] + "-" + params[:range]["ed(3i)"] + " 23:59:59"

    p [start_date_params, end_date_params]
    @data = @user.glucose_meters.custom_date(DateTime.parse(start_date_params), DateTime.parse(end_date_params))
  end

  def index
    redirect_to controller: 'glucose_meters', action: 'new'
  end


  def new
    @glucose_meter = GlucoseMeter.new
  end

  def create
    @glucose_meter = GlucoseMeter.new(glucose_meter_params)
    user = User.find_by_id(glucose_meter_params["user_id"].to_i)
    begin
      user.add_glucose_meter_data(glucose_meter_params["level"].to_f)
      respond_to do |format|
        flash[:notice] = "data saved"
        format.html { render :new, status: :created}
      end
    rescue StandardError => e
      respond_to do |format|
        flash[:alert] = e.message
        format.html { render :new, status: :ok}
      end
    end
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def glucose_meter_params
    params.require(:glucose_meter).permit(:level, :user_id)
  end

  def set_user
    @user = User.find_by_id(params[:glucose_meter_id])
  end
end
