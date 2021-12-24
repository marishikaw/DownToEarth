class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @post = Post.find(params[:post_id])
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.post_id = @post.id
      @post.create_notification_comment!(current_user, @comment.id)
      unless @comment.save
        render 'error'
      end
    else
      flash[:alert] = "アカウント登録もしくはログインしてください。"
      redirect_to post_path(params[:post_id])
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])
    comment.destroy
  end

  # -------------プライベートメソッド---------------------
  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
