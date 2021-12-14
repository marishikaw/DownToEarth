class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    unless @comment.save
      render 'error'
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
