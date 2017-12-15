class Island < ApplicationRecord
  validates :title, presence: true
  validates :island_type, presence: true
  validates :description, presence: true
  validates :size, presence: true, numericality: { greater_than: 1 }
  validates :location, presence: true
  validates :nb_accomodation, presence: true, numericality: { greater_than: 1 }
  validates :max_person, presence: true, numericality: { greater_than: 1 }
  validates :max_bed_room, presence: true, numericality: { greater_than: 1 }
  validates :max_bed, presence: true, numericality: { greater_than: 1 }
  validates :max_bath_room, presence: true, numericality: { greater_than: 1 }
  validates :address, presence:true
  validates :island_options, presence:true
  validates :price_by_night, numericality: { only_integer: true }
  mount_uploader :image, ImageUploader
  validates :title, presence: true, length: {maximum: 65}
  validates :description, presence: true, length: {maximum: 300}
  validates_processing_of :image
  validate :image_size_validation
  scope :island_options, -> (island_options) {where island_options: island_options}
  scope :location, -> (location) {where location: location}

  belongs_to :user
  has_many :bookings
  has_many :ratings, through: :bookings

  def self.add_bookings
    joins("LEFT JOIN bookings ON bookings.island_id = islands.id")
        .includes(:bookings)
  end

  def self.search(search)
    if search
      where('lower(title) LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end

  def self.not_available_list(start_date, end_date)
    add_bookings()
      .where('(? <= bookings.start_date AND bookings.start_date <= ?)
        OR (? <= bookings.end_date AND bookings.end_date <= ?)
        OR (bookings.start_date <= ? AND ? <= bookings.end_date)
        OR (bookings.start_date <= ? AND ? <= bookings.end_date)',
        start_date, end_date, start_date, end_date, start_date, start_date, end_date, end_date)
  end

  # Return a boolean depending if the island is available or not
  def is_available_between(start_date, end_date)
    number_of_booking = self.bookings.where('(? <= bookings.start_date AND bookings.start_date <= ?)
        OR (? <= bookings.end_date AND bookings.end_date <= ?)
        OR (bookings.start_date <= ? AND ? <= bookings.end_date)
        OR (bookings.start_date <= ? AND ? <= bookings.end_date)',
        start_date, end_date, start_date, end_date, start_date, start_date, end_date, end_date).count

    return  number_of_booking <= 0
  end

  def average_rating
    self.ratings.average(:rating_score)
  end

  private
  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end

end
