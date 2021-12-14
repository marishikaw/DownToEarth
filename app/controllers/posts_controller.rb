class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_q, only: [:timeline, :index, :search, :hashtag]

  def timeline
    if user_signed_in?
      @posts = Post.includes([:user], [:post_images])
               .where(user_id: [current_user.id, *current_user.following_ids]).order(id: "DESC")
               .page(params[:page]).per(2)
    else
      @posts = Post.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(2)
    end
  end

  def index
    @posts = Post.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(2)
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
    redirect_to posts_path
  end

  def hashtag
    @user = current_user
    @hashtag = Hashtag.find_by(name: params[:name])
    @posts = @hashtag.posts.includes([:user], [:post_images]).order(id: "DESC").page(params[:page]).per(2)
  end
  
  def search
    @results = @q.result.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(2)
  end

  # -------------プライベートメソッド------------------------------------------
  private
    def set_post
      @post = Post.find(params[:id])
    end
    
    def set_q
      @q = Post.ransack(params[:q])
    end
    
    def post_params
      params.require(:post).permit(:caption, post_images_images: [])
    end
end
