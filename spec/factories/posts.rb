FactoryBot.define do
  factory :post do
    association :user
    caption { Faker::Lorem.characters(number: 20) }

    after(:build) do |built_item|
      built_item.post_images << FactoryBot.build(:post_image, post: built_item)
    end  
  end

  # factory :image do
  #   photo { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.jpg"), 'image/jpg') }
  # end
end
