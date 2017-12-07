class Island < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :island_type, presence: true
  validates :description, presence: true
  validates :size, presence: true
  validates :location, presence: true
  validates :nb_accomodation, presence: true
  validates :max_person, presence: true
  validates :max_bed_room, presence: true
  validates :max_bed, presence: true
  validates :max_bath_room, presence: true
  validates :address, presence:true
  validates :island_options, presence:true
  validates :price_by_night, numericality: { only_integer: true, greater_than: 50 }
end
