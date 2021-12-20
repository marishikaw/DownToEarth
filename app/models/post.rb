class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  # いいねの存在を確認
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # ハッシュタグを取得
  after_create do
    post = Post.find_by(id: self.id)
    hashtags = self.caption.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) # ハッシュタグを検出
    post.hashtags = []
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#')) # 先頭の'#'を削除
      post.hashtags << tag
    end
  end

  before_update do
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = self.caption.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  # 画像アップロード
  accepts_attachments_for :post_images, attachment: :image

  # バリデーション
	FILE_NUMBER_LIMIT = 4
  validate :validate_number_of_files
	validates :caption, length: {maximum: 1000}

  #	プライベートメソッド--------------------------------------------
  private
    def validate_number_of_files
      image_size = post_images.length
      if image_size == 0
        errors.add(:image, "を選択してください。")
      elsif FILE_NUMBER_LIMIT <= image_size
        errors.add(:image, "は#{FILE_NUMBER_LIMIT}点まで投稿できます。")
      else
        return
      end
    end
end
