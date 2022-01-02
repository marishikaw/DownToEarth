class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_post_new, except: [:new]
  before_action :set_news_index, only: [:timeline, :index, :hashtag, :search]
  before_action :set_hashtag, only: [:timeline, :index, :hashtag, :search]
  before_action :set_q, except: [:create, :update, :destroy]

  def timeline
    if user_signed_in?
      @posts = Post.includes([:user], [:post_images])
               .where(user_id: [current_user.id, *current_user.following_ids]).order(id: "DESC")
               .page(params[:page]).per(10)
    else
      @posts = Post.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(10)
    end
  end

  def index
    @posts = Post.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(10)
  end

  def new
    @post_new = Post.new
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
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = '削除しました。'
    redirect_to user_path(@post.user)

    # ハッシュタグも削除したい場合は"該当ハッシュタグに紐づく投稿が最後の1件だったら削除"とする。
  end

  def hashtag
    @user = current_user
    @hashtag = Hashtag.find_by(name: params[:name])
    @posts = @hashtag.posts.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(10)
  end

  def search
    @results = @q.result.includes([:user], [:post_images]).all.order(id: "DESC").page(params[:page]).per(10)
  end

  # -------------プライベートメソッド------------------------------------------
  private
    def post_params
      params.require(:post).permit(:caption, post_images_images: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def set_post_new
      @post_new = Post.new
    end

    def set_news_index
      require 'news-api'
      news = News.new(ENV['NEWS_API_KEY'])
      # 検索ワード"サステナブル"
      sustainable = "%E3%82%B5%E3%82%B9%E3%83%86%E3%83%8A%E3%83%96%E3%83%AB"
      @news = news.get_everything(q: (sustainable),
                                  sortBy: "popularity",
                                  pageSize: 10)
    end

    def set_hashtag
      @hashtags = Hashtag.all.order(created_at: "DESC").limit(10)
    end

    def set_q
      @q = Post.ransack(params[:q])
    end
end
