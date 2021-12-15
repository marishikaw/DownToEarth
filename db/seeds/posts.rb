puts 'posts ...'

captions = [
    'You play with the cards you’re dealt..Whatever that means',
    'They say the best way is just to live one day at a time..',
    'I’m not getting old. I’m just becoming classic.',
    'No problem is so big or so complicated that it can’t be run away from.',
    'Now that you’ve hit bottom, you could start over.',
    'I am not lucky. I am just grateful ＆ feel very blessed.',
    'Life is like an ice cream cone.. You have to learn to lick it!',
    'If you want something done right, you should do it yourself!',
    'I need plenty of rest in case tomorrow is a great day..',
    'Be yourself. No one can say you’re doing it wrong.',
    'Keep looking up…That’s the secret of life…',
    'Are you depressed?The humor may be the one which isn’t enough in your life...',
    'I’m a smart person...I just do stupid things..',
    'Kind words of lip service only is good for nothing.',
    'No, there’s nothing wrong with being trusting.. You’re just young..',
  ]

User.all.each do |user|
  user.posts.create!(caption: captions.sample)
end
