class BookingsController < ApplicationController
  def create
    @booking = Booking.new(new_booking_params)
    @booking.user_id = current_user.id

    if @booking.save
      redirect_to @booking, notice: 'Island is booked.'
    else
      redirect_to @island.find(params['booking']['island_id'])
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @island = Island.find(@booking.island_id)
  end

  private
    def new_booking_params
      params.require(:booking).permit(:island_id, :start_date, :end_date)
    end
end
