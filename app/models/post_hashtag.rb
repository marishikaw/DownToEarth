class PostHashtag < ApplicationRecord
  # アソシエーション
  belongs_to :post
  belongs_to :hashtag
  
  # バリデーション
  with_options presence: true do
    validates :post_id
    validates :hashtag_id
  end	
end