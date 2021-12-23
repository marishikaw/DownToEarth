FactoryBot.define do
  factory :post_image do
    association :post
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.jpg"), 'image/jpg') }
  end
end
