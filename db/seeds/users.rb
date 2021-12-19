puts 'users ...'

users = [
    {email: '1@example.com', name: 'Mike', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon1.png")},
    {email: '2@example.com', name: 'Will', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon2.png")},
    {email: '3@example.com', name: 'Dustin', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon3.png")},
    {email: '4@example.com', name: 'Lucas', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon4.png")},
    {email: '5@example.com', name: 'Eleven', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon5.png")},
    {email: '6@example.com', name: 'Max', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon6.png")},
    {email: '7@example.com', name: 'Steve', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon7.png")},
    {email: '8@example.com', name: 'Robin', password: 'aaaaaa', icon: File.open("./app/assets/images/seeds/icon8.png")},
  ]

users.each do |user|
  user = User.create!(
    email: user[:email],
    name: user[:name],
    password: user[:password],
    icon: user[:icon]
  )
end
