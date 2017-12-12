class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show]
  before_action :show_access_right, only: [:show]

  def index
    user = User.find(current_user.id)
    @bookings = user.bookings
  end

  def create
    search = params['booking']

    @island = Island.find(search['island_id'])
    is_available = @island.is_available_between(search['start_date'], search['end_date'])

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
    @island = Island.find(@booking.island_id)
  end

  private
    def new_booking_params
      params.require(:booking).permit(:island_id, :start_date, :end_date)
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end

    def show_access_right
      is_island_owner = @booking.island.user.id == current_user.id
      is_booking_author = @booking.user.id == current_user.id

      if !(is_booking_author || is_island_owner)
        redirect_to @booking.island
      end
    end
end
