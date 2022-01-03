puts "posts ..."

# ユーザーID：18の投稿を40件作成
40.times do                                                                             # 別テーブルのデータを取得するためnewメソッドを使用
  tmp_post = Post.new(
    user_id: 18,
    caption: "You play with the cards you’re dealt..Whatever that means #エコ #eco",
  )

  tmp_post.post_images.build                                                            # buildでpost_imagesテーブルの画像を取得
  tmp_post.post_images[0].image = File.open("./app/assets/images/seeds/post-image.jpg")
  tmp_post.save!
end

# ユーザーID：1〜17の投稿を15件ずつ作成
17.times do |n|
  n += 1
  15.times do
    tmp_post = Post.new(
      user_id: n,
      caption: "You play with the cards you’re dealt..Whatever that means #エコ #eco",
    )

    tmp_post.post_images.build
    tmp_post.post_images[0].image = File.open("./app/assets/images/seeds/post-image.jpg")
    tmp_post.save!
  end
end

# ユーザーID：17〜18の投稿を作成
posts = [
    {user_id: 11, caption: "They say the best way is just to live one day at a time.. #エコフレンドリー", image: File.open("./app/assets/images/seeds/post-image-1.jpg")},
    {user_id: 12, caption: "I’m not getting old. I’m just becoming classic. #エコフレンドリー #プラスチックフリー", image: File.open("./app/assets/images/seeds/post-image-2.jpg")},
    {user_id: 13, caption: "No problem is so big or so complicated that it can’t be run away from. #サステナブル", image: File.open("./app/assets/images/seeds/post-image-3.jpg")},
    {user_id: 14, caption: "Now that you’ve hit bottom, you could start over. #マイボトル #持続可能な暮らし", image: File.open("./app/assets/images/seeds/post-image-4.jpg")},
    {user_id: 15, caption: "I am not lucky. I am just grateful ＆ feel very blessed. #サステナブル #ヴィーガン", image: File.open("./app/assets/images/seeds/post-image-5.jpg")},
    {user_id: 16, caption: "Life is like an ice cream cone.. You have to learn to lick it! #エコ #環境問題", image: File.open("./app/assets/images/seeds/post-image-6.jpg")},
    {user_id: 17, caption: "If you want something done right, you should do it yourself! #エコフレンドリー", image: File.open("./app/assets/images/seeds/post-image-7.jpg")},
    {user_id: 18, caption: "They say the best way is just to live one day at a time.. #エコフレンドリー", image: File.open("./app/assets/images/seeds/post-image-8-1.jpg")},
    {user_id: 18, caption: "I’m not getting old. I’m just becoming classic. #エコフレンドリー #プラスチックフリー", image: File.open("./app/assets/images/seeds/post-image-8-2.jpg")},
    {user_id: 18, caption: "No problem is so big or so complicated that it can’t be run away from. #リサイクル #サステナブル", image: File.open("./app/assets/images/seeds/post-image-8-3.jpg")},
    {user_id: 18, caption: "Now that you’ve hit bottom, you could start over. #持続可能な暮らし", image: File.open("./app/assets/images/seeds/post-image-8-4.jpg")},
    {user_id: 18, caption: "I am not lucky. I am just grateful ＆ feel very blessed. #サステナブル", image: File.open("./app/assets/images/seeds/post-image-8-5.jpg")},
    {user_id: 18, caption: "Life is like an ice cream cone.. You have to learn to lick it! #エコ #環境問題", image: File.open("./app/assets/images/seeds/post-image-8-6.jpg")},
    {user_id: 18, caption: "If you want something done right, you should do it yourself! #エコフレンドリー", image: File.open("./app/assets/images/seeds/post-image-8-7.jpg")},
    {user_id: 18, caption: "No problem is so big or so complicated that it can’t be run away from. #リサイクル", image: File.open("./app/assets/images/seeds/post-image-8-8.jpg")},
  ]

posts.each do |post|
  tmp_post = Post.new(
    user_id: post[:user_id],
    caption: post[:caption],
  )

  tmp_post.post_images.build
  tmp_post.post_images[0].image = post[:image]
  tmp_post.save!
end
