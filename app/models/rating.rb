class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  has_one :island, through: :booking

  validates :rating_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
