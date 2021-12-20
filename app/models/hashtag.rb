class Hashtag < ApplicationRecord
	# アソシエーション
  has_many :post_hashtags, dependent: :delete_all
  has_many :posts, through: :post_hashtags

  # バリデーション
  validates :name, presence: true, length: { maximum: 25}
end
