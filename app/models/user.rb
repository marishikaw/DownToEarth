class User < ApplicationRecord
  # -------------ユーザー認証---------------------------------------------------
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # -------------アソシエーション-----------------------------------------------
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # 自分がフォローされる（被フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy            # 自分がフォローする（与フォロー）側の関係性
  has_many :followers, through: :reverse_of_relationships, source: :follower                                      # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followings, through: :relationships, source: :followed                                                # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy      # 自分が通知する側の関係性
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy     # 自分が通知される側の関係性

  # -------------リレーション機能用メソッド-------------------------------------
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  # -------------リレーションの通知---------------------------------------------
  def create_notification_follow!(current_user)
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and action = ? ",
      current_user.id, id, 'follow'
    ])
    if temp.blank?
      notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
      notification.save if notification.valid?
    end
  end

  # -------------画像アップ用メソッド-------------------------------------------
  attachment :icon

  # -------------バリデーション-------------------------------------------------
  validates :name, length: {maximum: 20, minimum: 1}
  validates :introduction, length: {maximum: 50}
end
