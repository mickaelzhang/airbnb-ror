class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :island

  def duration
    (self.end_date - self.start_date).to_i + 1
  end

  def price
    self.island.price_by_night * self.duration
  end

  # Check if an instance is done
  def is_done(is_done = true)
    if is_done
      return self.where('end_date < ?', Date.today)
    else
      return self.where('? <= end_date', Date.today)
    end
  end

  # Check if list of bookings are done
  def self.are_done(are_done = true)
    if are_done
      return where('end_date < ?', Date.today)
    else
      return where('? <= end_date', Date.today)
    end
  end
end
