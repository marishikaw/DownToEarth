class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def timeline
    if user_signed_in?
      @posts = Post.includes([:user]).includes([:post_images]).where(user_id: [current_user.id, *current_user.following_ids]).order(id: "DESC")
    else
      @posts = Post.includes([:user]).includes([:post_images]).all.order(id: "DESC")
    end
  end

  def index
    @posts = Post.includes([:user]).includes([:post_images]).all.order(id: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = 'アップロードしました。'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    user = @post.user
    if user != current_user
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '修正しました。'
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def hashtag
    @user = current_user
    @hashtag = Hashtag.find_by(name: params[:name])
    @posts = @hashtag.posts.order(id: "DESC")
  end

  # プライベートメソッド------------------------------------------
  private

  def post_params
    params.require(:post).permit(:caption, post_images_images: [])
  end
end
