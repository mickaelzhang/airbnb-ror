class HomeController < ApplicationController
  def index
    @booking = Booking.new
  end
end
