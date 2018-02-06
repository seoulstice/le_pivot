FactoryBot.define do
  factory :item do
    title { Faker::Commerce.product_name }
    description { Faker::Hipster.sentence }
    price { Faker::Commerce.price }
    image File.open("./spec/support/images/test_image.jpg")
    category { Faker::Job.field }
  end
end
