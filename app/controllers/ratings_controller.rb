class RatingsController < ApplicationController
  def create
    rating = Rating.new(rating_params)
    rating.user_id = current_user.id

    if rating.save
      redirect_to bookings_path, notice: "#{rating.rating_score}/5 for #{rating.island.title}"
    else
      redirect_to bookings_path, notice: "The score is wrong."
    end
  end

  private
    def rating_params
      params.require(:rating).permit(:booking_id, :rating_score)
    end
end
