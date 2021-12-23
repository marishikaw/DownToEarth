FactoryBot.define do
  factory :post do
    association :user
    caption { Faker::Lorem.characters(number: 20) }

    after(:build) do |built_item|
      built_item.post_images << FactoryBot.build(:post_image, post: built_item)
    end  
  end
end
