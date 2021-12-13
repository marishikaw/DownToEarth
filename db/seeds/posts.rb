puts 'posts ...'

User.limit(10).each do |user|
  user.posts.create!(caption: Faker::Emotion.unique.adjective)
end