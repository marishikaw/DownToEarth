class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :set_post_new

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes([:post_images]).order(id: "DESC").page(params[:page]).per(10)
  end

  def index
    @users = User.all.order(id: "DESC")
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = '更新しました'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  # -------------プライベートメソッド---------------------------
  private
    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end
    
    def user_params
      params.require(:user).permit(:name, :introduction, :icon)
    end

    def set_post_new
      @post_new = Post.new
    end
end