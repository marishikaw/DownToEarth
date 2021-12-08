class Tag < ApplicationRecord
	# アソシエーション
  has_many :tag_maps, dependent: :destroy
  has_many :posts, through: :tag_maps
  
  # バリデーション
  validates :name, uniqueness: true	
end