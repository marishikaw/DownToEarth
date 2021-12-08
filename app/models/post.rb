class Post < ApplicationRecord
	# アソシエーション
	belongs_to :user
	has_many :post_images, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  
  # いいね確認用メソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # タグ保存・更新メソッド
  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      micropost_tag = Tag.find_or_create_by(name: new_name)
      self.tags << micropost_tag
    end
  end
  
  # 画像アップ用メソッド
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