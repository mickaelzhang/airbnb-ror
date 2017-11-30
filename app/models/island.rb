class Island < ApplicationRecord
  validates :title, presence: true, length: {maximum: 65}
  validates :description, presence: true, length: {maximum: 300}

  belongs_to :user
end
