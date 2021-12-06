class Post < ApplicationRecord
	# アソシエーション
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
  
  # いいね機能用（ユーザーの存在をチェック）
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # 画像アップ用メソッド
  attachment :image
  
  # バリデーション
	validates :caption, length: {maximum: 200}
end