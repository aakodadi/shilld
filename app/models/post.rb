class Post < ApplicationRecord
  validates :body, presence: true, length: { maximum: 5000 }

  belongs_to :user
end
