class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
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
  
  # 退会画面
  def unsubscribe
    @user = User.find(params[:id])
  end

  # 退会処理の実行
  def withdraw
    user = current_customer
    if user.update(is_deleted: true)
      reset_session
      redirect_to root_path
    end      
  end

  # プライベートメソッド--------------------------------------
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :icon)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end