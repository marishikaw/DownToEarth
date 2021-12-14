puts 'users ...'

users = [
    {email: '1@example.com', name: 'Lonnie', password: 'aaaaaa'},
    {email: '2@example.com', name: 'Becky', password: 'aaaaaa'},
    {email: '3@example.com', name: 'Dustin', password: 'aaaaaa'},
    {email: '4@example.com', name: 'Steve', password: 'aaaaaa'},
    {email: '5@example.com', name: 'Eleven', password: 'aaaaaa'},
    {email: '6@example.com', name: 'Will', password: 'aaaaaa'},
    {email: '7@example.com', name: 'Joyce', password: 'aaaaaa'},
    {email: '8@example.com', name: 'Jonathan', password: 'aaaaaa'},
    {email: '9@example.com', name: 'Nancy', password: 'aaaaaa'},
    {email: '10@example.com', name: 'Diane', password: 'aaaaaa'},
    {email: '11@example.com', name: 'Jim', password: 'aaaaaa'},
    {email: '12@example.com', name: 'Lucas', password: 'aaaaaa'},
    {email: '13@example.com', name: 'Mike', password: 'aaaaaa'},
    {email: '14@example.com', name: 'Terry', password: 'aaaaaa'},
    {email: '15@example.com', name: 'Barbara', password: 'aaaaaa'},
  ]

users.each do |user|
  user = User.create!(
    email: user[:email],
    name: user[:name],
    password: user[:password]
  )
end
