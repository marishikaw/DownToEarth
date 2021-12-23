FactoryBot.define do
  factory :hashtag do
    association :post_hashtag
    association :post
    name { Faker::Lorem.characters(number: 20) }
  end
end
