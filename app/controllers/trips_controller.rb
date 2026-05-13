class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = Trip.available.order(departure_time: :asc)
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
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

  private

  def trip_params
    params.require(:trip).permit(
      :origin, :destination, :departure_time,
      :price, :available_seats, :university
    )
  end
end