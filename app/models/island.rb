class Island < ApplicationRecord
  belongs_to :user

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
end
