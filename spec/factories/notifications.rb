FactoryBot.define do
  factory :notification do
    association :user
    association :post
    association :comment

    visitor_id { FactoryBot.create(:user).id }
    visited_id { FactoryBot.create(:user).id }
  end
end
