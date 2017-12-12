class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true, length: {maximum: 65}
  validates :last_name, presence: true, length: {maximum: 65}

  has_many :islands
  has_many :bookings
  has_many :ratings
end
