class Post < ApplicationRecord
  # -------------アソシエーション-----------------------------------------------
  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_hashtags, dependent: :delete_all
  has_many :hashtags, through: :post_hashtags
  has_many :notifications, dependent: :destroy

  # -------------いいね済みかどうかを確認---------------------------------------
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # -------------いいね・コメントの通知-----------------------------------------
  # いいねの通知
  def create_notification_favorite!(current_user)
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", 
      current_user.id, user_id, id, 'favorite'
    ])                                                                    # いいねされてないレコードを探す
    if temp.blank?                                                        # いいねされていない場合のみ通知レコードを作成
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメントの通知
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])        # 自分以外にコメントしてる人をすべて取得し全員に通知を送る
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?  # まだ誰もコメントしていない場合は投稿者に通知を送る
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # -------------ハッシュタグを取得---------------------------------------------
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

  # -------------画像アップロード-----------------------------------------------
  accepts_attachments_for :post_images, attachment: :image

  # -------------バリデーション-------------------------------------------------
	FILE_NUMBER_LIMIT = 4
  validate :validate_number_of_files
	validates :caption, length: {maximum: 500}

  #	-------------プライベートメソッド-------------------------------------------
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
