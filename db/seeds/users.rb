puts "users ..."

users = [
    {email: "1@example.com", name: "Mike", introduction: "Hi! I'm Mike", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon1.png")},
    {email: "2@example.com", name: "Will", introduction: "Hi! I'm Will", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon2.png")},
    {email: "3@example.com", name: "Dustin", introduction: "Hi! I'm Dustin", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon3.png")},
    {email: "4@example.com", name: "Lucas", introduction: "Hi! I'm Lucas", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon4.png")},
    {email: "5@example.com", name: "Eleven", introduction: "Hi! I'm Eleven", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon5.png")},
    {email: "6@example.com", name: "Max", introduction: "Hi! I'm Max", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon6.png")},
    {email: "7@example.com", name: "Steve", introduction: "Hi! I'm Steve", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon7.png")},
    {email: "8@example.com", name: "Robin", introduction: "Hi! I'm Robin", password: "aaaaaa", icon: File.open("./app/assets/images/seeds/icon8.png")},
  ]

users.each do |user|
  user = User.create!(
    email: user[:email],
    name: user[:name],
    introduction: user[:introduction],
    password: user[:password],
    icon: user[:icon]
  )
end
