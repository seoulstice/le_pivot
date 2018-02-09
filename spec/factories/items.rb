FactoryBot.define do
  factory :item do
    category
    
    title { Faker::Commerce.product_name }
    description { Faker::Hipster.sentence }
    price { Faker::Commerce.price }
    image File.open("./spec/support/images/test_image.jpg")
  end
end
