class HomeController < ApplicationController
  def index
    @trips = Trip.available.order(departure_time: :asc).limit(6)
  end
end