class Post < ApplicationRecord
  validates :body, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true

  belongs_to :user
end
