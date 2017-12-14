class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true, length: {maximum: 65}
  validates :last_name, presence: true, length: {maximum: 65}

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  has_many :islands
  has_many :bookings
  has_many :ratings

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
