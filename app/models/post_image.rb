class PostImage < ApplicationRecord
  belongs_to :post
  attachment :image
  
  # image_idは投稿後に作成されるのでバリデーションしない
end