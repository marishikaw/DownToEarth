class HomesController < ApplicationController
	def top
		# ログアウト状態
		@posts = Post.all
		# ログイン時
		# タイムラインが1以上だったらタイムラインを表示
		# ゼロだったらどうするかどうするか考える
  end

	def about
  end
end