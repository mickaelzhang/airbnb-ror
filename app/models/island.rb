class Island < ApplicationRecord
  validates :title, presence: true, length: {maximum: 65}
  validates :description, presence: true, length: {maximum: 300}

  belongs_to :user
  has_many :bookings

  def self.add_bookings
    joins("LEFT JOIN bookings ON bookings.island_id = islands.id")
        .includes(:bookings)
  end

  def self.not_available_list(start_date, end_date)
    add_bookings()
      .where('(? <= bookings.start_date AND bookings.start_date <= ?)
        OR (? <= bookings.end_date AND bookings.end_date <= ?)
        OR (bookings.start_date <= ? AND ? <= bookings.end_date)
        OR (bookings.start_date <= ? AND ? <= bookings.end_date)',
        start_date, end_date, start_date, end_date, start_date, start_date, end_date, end_date)
  end

  def self.available_between(start_date, end_date)
    joins("LEFT JOIN bookings ON bookings.island_id = islands.id")
      .includes(:bookings)
      # .where("(? < bookings.start_date) OR (bookings.end_date < ?) OR (bookings.id is null)", end_date, start_date)
  end

  scope :by_id_available_between, -> (island_id, start_date, end_date) {
    available_between(start_date, end_date)
      .exists?(:islands => { :id => island_id })
  }
end
