class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_driver, only: [:new, :create, :destroy]

  def index
    @trips = Trip.available.order(departure_time: :asc)
  end

  def new
    if current_user.vehicle.nil?
      redirect_to new_vehicle_path, alert: "Primero debes registrar tu vehículo para publicar rutas."
      return
    end

    @trip = current_user.trips.build
  end

  def create
    @trip = current_user.trips.build(trip_params)
    @trip.status = :active
    @trip.university = @trip.destination

    if @trip.save
      redirect_to @trip, notice: "¡Viaje publicado exitosamente!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def destroy
    @trip = current_user.trips.find(params[:id])
    @trip.destroy

    redirect_to profile_path, notice: "Viaje eliminado correctamente."
  end

  private

  def require_driver
    unless current_user.driver?
      redirect_to root_path, alert: "Solo los conductores pueden publicar rutas."
    end
  end

  def trip_params
    params.require(:trip).permit(
      :origin,
      :destination,
      :departure_time,
      :price,
      :available_seats,
      :university
    )
  end
end