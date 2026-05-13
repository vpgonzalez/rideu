class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @vehicle = current_user.vehicle

    if current_user.driver?
      @trips = current_user.trips.order(departure_time: :desc)
    else
      @reservations = current_user.reservations.includes(:trip).order(created_at: :desc)
      @reserved_trips = @reservations.map(&:trip)
    end
  end

  def edit
    @user = current_user
    @vehicle = current_user.vehicle || current_user.build_vehicle
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Perfil actualizado correctamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:university, :phone, :role)
  end
end