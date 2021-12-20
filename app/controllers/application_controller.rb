class ApplicationController < ActionController::Base
  before_action :set_post_new
  before_action :set_q

  # -------------プライベートメソッド---------------------------
  private
    def set_post_new
      @post_new = Post.new
    end

    def set_q
      @q = Post.ransack(params[:q])
    end
end
