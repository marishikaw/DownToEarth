puts 'posts ...'

User.limit(20).each do |user|
  user.posts.create!(caption: Faker::Quotes::Shakespeare.hamlet_quote)
end
