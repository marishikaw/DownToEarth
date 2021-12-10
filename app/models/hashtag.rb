class Hashtag < ApplicationRecord
	# アソシエーション
  has_many :post_hashtags
  has_many :posts, through: :post_hashtags	
  
  # バリデーション
  validates :name, presence: true, length: { maximum:30}
end