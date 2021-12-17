class ApplicationController < ActionController::Base
  before_action :set_q

  # -------------プライベートメソッド---------------------------
  private
    def set_q
      @q = Post.ransack(params[:q])
    end    
end