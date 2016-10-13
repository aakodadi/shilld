class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }
  before_save { username.downcase! }
end
