class User < ApplicationRecord
  has_secure_password

  # Validates Email exists, is unique and follows the appropriate pattern
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }

  has_many :books
  has_one :profile, dependent: :destroy

end

