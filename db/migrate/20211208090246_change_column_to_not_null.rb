class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :post_images, :post_id, :integer, null: false
    change_column :post_images, :image_id, :string, null: false
    change_column :favorites, :user_id, :integer, null: false
    change_column :favorites, :post_id, :integer, null: false
    change_column :comments, :user_id, :integer, null: false
    change_column :comments, :post_id, :integer, null: false
    change_column :comments, :comment, :text, null: false
    change_column :relationships, :follower_id, :integer, null: false
    change_column :relationships, :followed_id, :integer, null: false
  end
end
