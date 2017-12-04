class Island < ApplicationRecord
  validates :title, presence: true, length: {maximum: 65}
  validates :description, presence: true, length: {maximum: 300}

  belongs_to :user
  has_many :bookings

  scope :available_between, -> (start_date, end_date) {
    joins("LEFT JOIN bookings ON bookings.island_id = islands.id")
      .includes(:bookings)
      .where("(? < bookings.start_date) OR (bookings.end_date < ?) OR (bookings.id is null)", end_date, start_date)
  }

  scope :by_id_available_between, -> (island_id, start_date, end_date) {
    available_between(start_date, end_date)
      .exists?(:islands => { :id => island_id })
  }
end
