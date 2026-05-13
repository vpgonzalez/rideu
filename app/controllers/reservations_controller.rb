class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @trip = Trip.find(params[:trip_id])

    if @trip.full?
      redirect_back fallback_location: trips_path, alert: "Este viaje está lleno."
      return
    end

    if current_user == @trip.user
      redirect_back fallback_location: trips_path, alert: "No puedes reservar tu propio viaje."
      return
    end

    @reservation = Reservation.new(
      user: current_user,
      trip: @trip,
      status: :pending
    )

    ActiveRecord::Base.transaction do
      @reservation.save!

      @trip.update!(
        available_seats: @trip.available_seats - 1
      )

      @trip.update!(status: :full) if @trip.available_seats <= 0
    end

    redirect_back fallback_location: trips_path, notice: "Reserva realizada correctamente."
  rescue ActiveRecord::RecordInvalid
    redirect_back fallback_location: trips_path, alert: "No se pudo realizar la reserva."
  end
end