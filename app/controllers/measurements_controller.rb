class MeasurementsController < ApplicationController
  def new
    @measurement = Measurement.new
  end
  
  def create
    @measurement = Measurement.new(msr_params)
    if(@measurement.save)
      flash.alert = "Measurement added"
      redirect_to new_measurement_path
    else
      flash.now.alert = "Error adding measurement"
      render 'new'
    end
  end
  
  def edit
    @measurment = Measurement.find(params[:id])
  end
  
  def update
    @measurment = Measurement.find(params[:id])
    if(@measurement.update(msr_params))
      redirect_to @measurement
    else
      render 'edit'
    end
  end
  
  def index
    @measurements = Measurement.all
  end
  
  def destroy
    @measurement = Measurement.find(params[:id])
    @measurement.destroy
    redirect_to measurements_path
  end
  
  ###############################################################
  private
  
    def msr_params
      params.require(:measurement).permit(:name, :abbr)
    end
end
