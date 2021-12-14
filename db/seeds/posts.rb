puts 'posts ...'

captions = [
    'I will speak daggers to her but use none.',
    'Do you think I am easier to be played on than a pipe?',
    'The lady doth protest too much, methinks.',
    'To be, or not to be, that is the question',
    'Rich gifts wax poor when givers prove unkind.',
    'Do you think I am easier to be played on than a pipe?',
    'There is nothing either good or bad, but thinking makes it so.',
    'To be, or not to be, that is the question',
    'Doubt thou the stars are fire, doubt that the sun doth move, doubt truth to be a liar, but never doubt I love.',
  ]

User.all.each do |user|
  user.posts.create!(caption: captions.sample)
end
