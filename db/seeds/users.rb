puts "users ..."

10.times do |n|
    User.create!(
      email: "#{n + 1}@example.com",
      name: "user#{n + 1}",
      introduction: "Hi! I'm user#{n + 1}",
      password: "aaaaaa",
    )
end

users = [
    {email: "11@example.com", name: "Mike", introduction: "Hi! I'm Mike", password: "aaaaaa"},
    {email: "12@example.com", name: "Will", introduction: "Hi! I'm Will", password: "aaaaaa"},
    {email: "13@example.com", name: "Dustin", introduction: "Hi! I'm Dustin", password: "aaaaaa"},
    {email: "14@example.com", name: "Lucas", introduction: "Hi! I'm Lucas", password: "aaaaaa"},
    {email: "15@example.com", name: "Eleven", introduction: "Hi! I'm Eleven", password: "aaaaaa"},
    {email: "16@example.com", name: "Max", introduction: "Hi! I'm Max", password: "aaaaaa"},
    {email: "17@example.com", name: "Steve", introduction: "Hi! I'm Steve", password: "aaaaaa"},
    {email: "18@example.com", name: "Robin", introduction: "Hi! I'm Robin", password: "aaaaaa"},
  ]

users.each do |user|
  user = User.create!(
    email: user[:email],
    name: user[:name],
    introduction: user[:introduction],
    password: user[:password],
  )
end
