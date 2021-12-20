class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  # ---------フォロー機能を作成・保存・削除する-------------
  def create
    @user = User.find(params[:user_id])
    following = current_user.relationships.build(followed_id: params[:user_id])
    following.save
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
end