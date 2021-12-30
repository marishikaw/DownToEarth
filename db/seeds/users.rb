puts "users ..."

# ユーザーID：1~10をループ処理で追加
10.times do |n|
    User.create!(
      email: "#{n + 1}@example.com",
      name: "user#{n + 1}",
      introduction: "Hi! I'm user#{n + 1}",
      password: "aaaaaa",
    )
end

# ユーザーID:11~18件を追加
users = [
    {email: "11@example.com", name: "Mike", introduction: "Hi! I'm Mike", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-1.jpg")},
    {email: "12@example.com", name: "Will", introduction: "Hi! I'm Will", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-2.jpg")},
    {email: "13@example.com", name: "Dustin", introduction: "Hi! I'm Dustin", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-3.jpg")},
    {email: "14@example.com", name: "Lucas", introduction: "Hi! I'm Lucas", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-4.jpg")},
    {email: "15@example.com", name: "Eleven", introduction: "Hi! I'm Eleven", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-5.jpg")},
    {email: "16@example.com", name: "Max", introduction: "Hi! I'm Max", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-6.jpg")},
    {email: "17@example.com", name: "Steve", introduction: "Hi! I'm Steve", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-7.jpg")},
    {email: "18@example.com", name: "Robin", introduction: "Hi! I'm Robin", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon-8.jpg")},
  ]

users.each do |user|
  user = User.create!(
    email: user[:email],
    name: user[:name],
    introduction: user[:introduction],
    password: user[:password],
    icon: user[:icon],
  )
end
