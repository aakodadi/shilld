class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9.\-_]+\Z/

  has_secure_password

  before_save { email.downcase! }
  before_save { username.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 50 },
    format: { with: VALID_USERNAME_REGEX },
    uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
end
