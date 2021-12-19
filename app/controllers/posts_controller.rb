class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_post
  before_action :set_post_new
  before_action :set_q

  def timeline
    if user_signed_in?
      @posts = Post.includes([:user], [:post_images])
               .where(user_id: [current_user.id, *current_user.following_ids]).order(id: "DESC")
               .page(params[:page]).per(10)
      @hashtags = Hashtag.last(10)

    else
      @posts = Post.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(10)
      @hashtags = Hashtag.last(10)
    end
  end

  def index
    @posts = Post.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(10)
    @hashtags = Hashtag.all.last(10)
  end

  def new

  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = 'アップロードしました。'
      redirect_to post_path(@post)
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    user = @post.user
    if user != current_user
      redirect_to posts_path
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = '修正しました。'
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = '削除しました。'
    redirect_to user_path(@post.user)
  end

  def hashtag
    @user = current_user
    @hashtag = Hashtag.find_by(name: params[:name])
    @posts = @hashtag.posts.includes([:user], [:post_images]).order(id: "DESC").page(params[:page]).per(10)
    @hashtags = Hashtag.last(10)
  end

  def search
    @results = @q.result.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(10)
    @hashtags = Hashtag.last(10)
  end

  # -------------プライベートメソッド------------------------------------------
  private
    def set_post
      id = params[:id] || 1
      @post = Post.find(id)
    end

    def set_post_new
      @post_new = Post.new
    end

    def set_q
      @q = Post.ransack(params[:q])
    end

    def post_params
      params.require(:post).permit(:caption, post_images_images: [])
    end
end
