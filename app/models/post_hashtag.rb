class PostHashtag < ApplicationRecord
  # アソシエーション
  belongs_to :post
  belongs_to :hashtag

  # バリデーション
  with_options presence: true do
    validates :post_id, presence: true
    validates :hashtag_id, presence: true
  end
end
