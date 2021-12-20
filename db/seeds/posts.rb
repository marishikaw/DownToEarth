puts "posts ..."

posts = [
    {user_id: 1, caption: "You play with the cards you’re dealt..Whatever that means #エコ #eco", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
    {user_id: 2, caption: "They say the best way is just to live one day at a time.. #マイボトル #エコフレンドリー", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
    {user_id: 3, caption: "I’m not getting old. I’m just becoming classic. #エコフレンドリー #プラスチックフリー", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
    {user_id: 4, caption: "No problem is so big or so complicated that it can’t be run away from. #リサイクル #サステナブル", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
    {user_id: 5, caption: "Now that you’ve hit bottom, you could start over. #持続可能な暮らし", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
    {user_id: 6, caption: "I am not lucky. I am just grateful ＆ feel very blessed. #サステナブル #ヴィーガン", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
    {user_id: 7, caption: "Life is like an ice cream cone.. You have to learn to lick it! #エコ #環境問題", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
    {user_id: 8, caption: "If you want something done right, you should do it yourself! #エコフレンドリー", image: File.open("./app/assets/images/seeds/post_image1.jpg")},
  ]

posts.each do |post|
                                                # 別テーブルのデータを取得するためnewメソッドを使用
  tmp_post = Post.new(
    user_id: post[:user_id],
    caption: post[:caption],
  )

  tmp_post.post_images.build                    # buildでpost_imagesテーブルの画像を取得
  tmp_post.post_images[0].image = post[:image]  #取得した画像を配列の一番目に入れる
 
  tmp_post.save!
end
