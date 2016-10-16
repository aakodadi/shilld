class User < ApplicationRecord
  attr_accessor :auth_token

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

  has_many :posts, dependent: :destroy

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Generates a random token.
    def generate_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.auth_token = User.generate_token
    update_attribute(:auth_digest, User.digest(auth_token))
  end

  def forget
    update_attribute(:auth_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(auth_token)
    return false if auth_digest.nil?
    BCrypt::Password.new(auth_digest).is_password?(auth_token)
  end
end
