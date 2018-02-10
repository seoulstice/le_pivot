FactoryBot.define do
  factory :item do
    category

    title { Faker::Commerce.product_name }
    description { Faker::Hipster.sentence }
    price { Faker::Commerce.price }
    image "http://res.cloudinary.com/tyjoo27/image/upload/v1518213324/cp82cjhrlplyxbet4gko.png"
  end
end
