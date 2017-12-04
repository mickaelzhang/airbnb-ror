class BookingsController < ApplicationController
  def create
    s = params['booking']
    is_available = !Island.not_available_list(s['start_date'], s['end_date'])
      .exists?(:islands => { :id => s['island_id'] })

    @island = Island.find(s['island_id'])

    if is_available
      @booking = Booking.new(new_booking_params)
      @booking.user_id = current_user.id

      if @booking.save
        redirect_to @booking, notice: "You have booked '#{@island.title}'."
      else
        redirect_to @island
      end
    else
      redirect_to @island, notice: "'#{@island.title}' is already booked at this date by someone else."
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
