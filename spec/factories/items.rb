FactoryBot.define do
  factory :item do
    category
    store

    title { Faker::Commerce.unique.product_name }
    description { Faker::Hipster.sentence }
    price { Faker::Commerce.price }
    image do
      gray = [true, false].sample
      size = rand(200..400)
      Faker::Fillmurray.image(gray, size, size)
    end

    factory :item_not_unique do
      title { Faker::Commerce.product_name }
    end

  end
end
