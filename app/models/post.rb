class Post < ApplicationRecord
	# アソシエーション
	belongs_to :user
	has_many :post_images, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
  
  # いいね確認用メソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # 画像アップ用メソッド
  accepts_attachments_for :post_images, attachment: :image
  
  # バリデーション
	FILE_NUMBER_LIMIT = 4
  validate :validate_number_of_files
	validates :caption, length: {maximum: 200}
	
  #	プライベートメソッド------------------------------------------------------
  private	
	
  def validate_number_of_files
    return if post_images.length <= FILE_NUMBER_LIMIT
     errors.add(:image, "の添付は#{FILE_NUMBER_LIMIT}枚までです。")
  end
end