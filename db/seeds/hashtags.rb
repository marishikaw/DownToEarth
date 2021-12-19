puts 'hashtags ...'

hashtags = [
    {name: "リサイクル"},
    {name: "エコ"},
    {name: "サステナブル"},
    {name: "持続可能な暮らし"},
    {name: "eco"},
    {name: "ヴィーガン"},
    {name: "環境問題"},
    {name: "マイボトル"},
    {name: "エコフレンドリー"},
    {name: "プラスチックフリー"},
  ]

hashtags.each do |hashtag|
  hashtag = Hashtag.create!(
    name: user[:name]
  )
end
