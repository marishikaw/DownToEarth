class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def index
    @users = User.all
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
    @user = current_customer
  end

  def withdraw
    user = current_customer
    if user.update(is_deleted: true)
      reset_session
      redirect_to root_path
    end      
  end

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
