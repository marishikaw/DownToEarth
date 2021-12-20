class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post_new
  before_action :set_q

  # ---------フォロー機能を作成・保存・削除する-------------
  def create
    @user = User.find(params[:user_id])
    following = current_user.relationships.build(followed_id: params[:user_id])
    following.save
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = User.find(params[:user_id])
    following = current_user.relationships.find_by(followed_id: params[:user_id])
    following.destroy
  end

  # ---------フォロー・フォロワー一覧を表示する-------------
  def followings
     user = User.find(params[:user_id])
     @users = user.followings.order(id: "DESC")
  end

  def followers
     user = User.find(params[:user_id])
     @users = user.followers.order(id: "DESC")
  end

  # -------------プライベートメソッド---------------------------
  private
    def set_post_new
      @post_new = Post.new
    end
  
    def set_q
      @q = Post.ransack(params[:q])
    end  
end