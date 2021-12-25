class HomesController < ApplicationController
  def about
    @post_new = Post.new
    @q = Post.ransack(params[:q])
  end
end
