class HomesController < ApplicationController
  def about
    @q = Post.ransack(params[:q])
  end
end
