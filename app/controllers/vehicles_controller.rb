class VehiclesController < ApplicationController
  before_action :authenticate_user!

  def new
    @vehicle = current_user.vehicle || current_user.build_vehicle
  end

  def create
    if current_user.vehicle
      @vehicle = current_user.vehicle
      if @vehicle.update(vehicle_params)
        redirect_to profile_path, notice: "¡Vehículo actualizado exitosamente!"
      else
        render :new, status: :unprocessable_entity
      end
    else
      @vehicle = current_user.build_vehicle(vehicle_params)
      if @vehicle.save
        redirect_to profile_path, notice: "¡Vehículo registrado exitosamente!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :year, :plate, :color, :seats)
  end
end