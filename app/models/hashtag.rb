class Hashtag < ApplicationRecord
	# アソシエーション
  has_many :post_hashtags, dependent: :delete_all
  has_many :posts, through: :post_hashtags
end
