class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :island

  def duration
    (self.end_date - self.start_date).to_i + 1
  end

  def price
    self.island.price_by_night * self.duration
  end
end
