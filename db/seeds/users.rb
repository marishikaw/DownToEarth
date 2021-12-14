puts 'users ...'

15.times do |n|
  user = User.create!(
    email: "test#{n + 1}@com",
    name: Faker::TvShows::StrangerThings.unique.character,
    password: 'aaaaaa'
  )
end
