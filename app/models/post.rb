class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  # いいね
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # ハッシュタグ
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
	validates :caption, length: {maximum: 200}

  #	プライベートメソッド--------------------------------------------
  private
    def validate_number_of_files
      return if post_images.length <= FILE_NUMBER_LIMIT
      errors.add(:image, "の添付は#{FILE_NUMBER_LIMIT}枚までです。")
    end
end
